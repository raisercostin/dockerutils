#!/bin/bash

#some utilities
yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; } 
function execute {
  echo "$" "$@"
  eval $(printf '%q ' "$@") < /dev/tty
}
function config {
  source project.sh

  IMAGE=${REPOSITORY}$NAME:$VERSION
  EXTERNAL_IMAGE=${EXTERNAL_REPOSITORY}$NAME:$VERSION
}

function dd-rebuild(){
  config
  dd-image-rebuild
}
function dd-image-rebuild(){
  config
  dd-image-remove
  dd-image-build
}
function dd-build(){
  config
  dd-image-build
}
function dd-image-build(){
  config
  execute docker build . -t $IMAGE
}

function dd-image-remove(){
  config
  dd-remove
  execute docker rmi -f $IMAGE 
}

function dd-remove(){
  config
  dd-stop
  execute docker rm $NAME
}

function dd-stop(){
  config
  execute docker stop $NAME
}
function dd-recreate(){
  config
  dd-remove
  dd-create
}
function dd-create(){
  config
  dd-simple-create || dd-simple-create $START_CMD || (dd-image-build && dd-simple-create )
}

function dd-simple-create(){
  config
  local startCmd
  startCmd=${1:-}

  echo creation from exported/imported images need a start command: [$startCmd].
  execute docker create                   \
    --log-opt max-size=100M               \
    -p $EXTERNAL_HTTP_PORT:$HTTP_PORT     \
    --name=$NAME                          \
    $IMAGE $startCmd
}

function dd-recreate(){
  config
  dd-remove
  dd-create
}

function dd-run(){
  config
  execute docker run -t $IMAGE
}

function dd-restart(){
  config
  dd-stop
  dd-start
}

function dd-start(){
  config
  # Fail immediately if any of the pipelines fail
  #set -e

  if ! docker inspect $NAME >/dev/null 2>&1 ; then
    dd-create
  fi

  if [ $(docker ps -q -f name=$NAME | wc -l) -lt 1 ]; then
    execute docker start $NAME
  fi 
}

function dd-logs(){
  config
  execute docker logs --tail=10000 -f $NAME 
}

function dd-start-logs(){
  config
  dd-start
  dd-logs
}

function dd-restart-logs(){
  config
  dd-restart
  dd-logs
}

function dd-shell(){
  config
  execute docker exec -it $NAME bash
}

function dd-shell-root(){
  config
  execute docker exec -it --user root $NAME bash
}

function dd-attention-clean(){
  config
  echo remove dangling resources:
  execute docker system prune

  echo list docker containers:
  execute docker ps -a
  echo list docker images:
  execute docker images -a 
}

function dd-attention-clean-system(){
  config
  echo stop all containers
  execute docker stop $(docker ps -q)
  #echo remove all containers
  #docker rm $(docker ps -qa)
  #echo remove all images
  #docker rmi $(docker images -qa)
  
  #echo remove dangling resources:
  #docker system prune
  echo remove all resources
  execute docker system prune -a

  echo list docker containers:
  execute docker ps -a
  echo list docker images:
  execute docker images -a 
}

function dd-clean-orphan(){
  config
  echo clean docker orphan containers and images
  execute docker rm -v $(docker ps -a -q -f status=exited)
  execute docker rmi $(docker images -f "dangling=true" -q) 
}

function dd-tree(){
  config
  #!/bin/bash 
  #alias dockviz="docker run --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz"
  #dockviz images -tl
  execute docker run --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz images -tl 
}

# see https://medium.com/travis-on-docker/how-to-version-your-docker-images-1d5c577ebf54
# https://medium.com/@mccode/the-misunderstood-docker-tag-latest-af3babfd6375
function dd-image-release-in-progress(){
  config
  #set -ex
  # SET THE FOLLOWING VARIABLES
  # docker hub username
  USERNAME=treeder
  # image name
  IMAGE=helloworld
  # ensure we're up to date
  git pull
  # bump version
  docker run --rm -v "$PWD":/app treeder/bump patch
  version=`cat VERSION`
  echo "version: $version"
  # run build
  ./build.sh
  # tag it
  git add -A
  git commit -m "version $version"
  git tag -a "$version" -m "version $version"
  git push
  git push --tags
  docker tag $USERNAME/$IMAGE:latest $USERNAME/$IMAGE:$version
  # push it
  docker push $USERNAME/$IMAGE:latest
  docker push $USERNAME/$IMAGE:$version
}

function dd-info(){
  config
  DIR="$( pwd )"
  BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

  pwd="$(pwd)"
  error="Not defined in $pwd/project.sh"
  PORTS=`set|grep _PORT=|grep -v PORTS | sed -e 's/^/|   /'`
  COMMANDS=`set|grep ^dd-|uniq|sed -r -e 's/^\s*(.*)\s+\(\)/\1/'| sed -e 's/^/|   /'`
  #|tr '\n' ' '
  DESCRIPTION2=`echo "$DESCRIPTION" | sed -e 's/^/|   /'`


cat <<EOF
+=======================================+
| Entering project $(basename $pwd | tr a-z A-Z) at $pwd ...
|
| NAME       = ${NAME:-<missing>}
| VERSION    = ${VERSION:-<missing>}
| IMAGE      = ${IMAGE:-<missing>}
| HOST       = ${HOST:-<none> - optional for build-only components}
| REPOSITORY = ${REPOSITORY:-}
| NETWORK_NAME = ${NETWORK_NAME:-<missing>}
|
| PORTS
$PORTS
| DESCRIPTION
$DESCRIPTION2
| DIR=$DIR
| BASEDIR=$BASEDIR
| TARGET=$TARGET
|
|------------------------------------------------
| For pull/push to external repository
|
| EXTERNAL_REPOSITORY = ${EXTERNAL_REPOSITORY:-}
| EXTERNAL_IMAGE      = ${EXTERNAL_IMAGE:-}
|------------------------------------------------
| Available commands:
$COMMANDS
+=======================================+
EOF

  : ${NAME?$error}
  : ${VERSION?$error}
  : ${IMAGE?$error}
  #: ${NETWORK_NAME?$error}
}

function dd-import-from-file(){
  config
  local archive
  archive=${1:-${NAME}-${VERSION}-exported.tgz}
  execute cat $archive | pv | docker import - $IMAGE
}

function dd-export-to-file(){
  config
  local archive
  archive=${1:-${NAME}-${VERSION}-exported.tgz}
  execute docker export $NAME | pv | gzip -9 > $archive
}

function dd-import-from-repository(){
  config
  execute docker pull $EXTERNAL_IMAGE
  execute docker tag $EXTERNAL_IMAGE $IMAGE
}

function dd-export-to-repository(){
  config
  execute docker tag $IMAGE $EXTERNAL_IMAGE
  execute docker push $EXTERNAL_IMAGE
}

yell "to define docker ops run with [source ./dockutils.sh]"
