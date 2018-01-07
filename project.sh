#!/bin/bash

#Ended with a slash `/`.
REPOSITORY=mylocal/
NAME=my-hello-world
VERSION=0.3
DESCRIPTION="
A demo of dockerutils.
"

HTTP_PORT=8080

EXTERNAL_HTTP_PORT=$HTTP_PORT

#Needed if docker import/export are used
#Docker import/export loses the docker metadata (including the CMD).
START_CMD=/run.sh
#Docker import/export could happen in private repos. Ended with a slash `/`.
EXTERNAL_REPOSITORY=registry.gitlab.com/raisercostin/docker2/
