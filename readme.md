# Docker utils

This is a set of utilities focused on the main scenarios when developing with docker:

- start (and build image, create container, start container, log everything alongside)
  `dd-start-logs`

- remove image (and stop container, destroy container, remove image to recreate it from scratch)
  `dd-image-remove`
- there is a set of dependencies between them 
  ```
  digraph G {
    "dd-start" -> "dd-create"
    "dd-restart" -> "dd-stop"
    "dd-restart" -> "dd-start"
    "dd-rebuild" -> "dd-image-rebuild"
    "dd-image-rebuild" -> "dd-image-remove"
    "dd-image-rebuild" -> "dd-image-build"
    "dd-build" -> "dd-image-build"
    "dd-image-remove" [color=red]
    "dd-image-remove" -> "dd-remove"
    "dd-remove" -> "dd-stop"
    "dd-recreate" -> "dd-remove"
    "dd-recreate" -> "dd-create"
    "dd-create" -> "dd-image-build"
    "dd-start-logs" [color=blue]
    "dd-start-logs" -> "dd-start"
    "dd-start-logs" -> "dd-logs"
    "dd-restart-logs" -> "dd-restart"
    "dd-restart-logs" -> "dd-logs"
  }
  ```
- svg
<svg width="534pt" height="332pt" viewBox="0.00 0.00 534.00 332.00" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
<g id="graph1" class="graph" transform="scale(1 1) rotate(0) translate(4 328)">
<title>G</title>
<polygon fill="white" stroke="white" points="-4,5 -4,-328 531,-328 531,5 -4,5"></polygon>
<!-- dd&#45;start -->
<g id="node1" class="node"><title>dd-start</title>
<ellipse fill="none" stroke="black" cx="128" cy="-162" rx="40.2988" ry="18"></ellipse>
<text text-anchor="middle" x="128" y="-157.8" font-family="Times,serif" font-size="14.00">dd-start</text>
</g>
<!-- dd&#45;create -->
<g id="node3" class="node"><title>dd-create</title>
<ellipse fill="none" stroke="black" cx="165" cy="-90" rx="46.4309" ry="18"></ellipse>
<text text-anchor="middle" x="165" y="-85.8" font-family="Times,serif" font-size="14.00">dd-create</text>
</g>
<!-- dd&#45;start&#45;&gt;dd&#45;create -->
<g id="edge2" class="edge"><title>dd-start-&gt;dd-create</title>
<path fill="none" stroke="black" d="M136.768,-144.411C141.083,-136.249 146.384,-126.22 151.223,-117.065"></path>
<polygon fill="black" stroke="black" points="154.459,-118.433 156.037,-107.956 148.27,-115.162 154.459,-118.433"></polygon>
</g>
<!-- dd&#45;image&#45;build -->
<g id="node14" class="node"><title>dd-image-build</title>
<ellipse fill="none" stroke="black" cx="413" cy="-18" rx="70.36" ry="18"></ellipse>
<text text-anchor="middle" x="413" y="-13.8" font-family="Times,serif" font-size="14.00">dd-image-build</text>
</g>
<!-- dd&#45;create&#45;&gt;dd&#45;image&#45;build -->
<g id="edge24" class="edge"><title>dd-create-&gt;dd-image-build</title>
<path fill="none" stroke="black" d="M200.209,-78.1625C207.094,-76.0855 214.266,-73.9511 221,-72 266.429,-58.8367 318.122,-44.6098 356.418,-34.2136"></path>
<polygon fill="black" stroke="black" points="357.614,-37.5159 366.35,-31.5217 355.782,-30.7597 357.614,-37.5159"></polygon>
</g>
<!-- dd&#45;restart -->
<g id="node4" class="node"><title>dd-restart</title>
<ellipse fill="none" stroke="black" cx="59" cy="-234" rx="48.0513" ry="18"></ellipse>
<text text-anchor="middle" x="59" y="-229.8" font-family="Times,serif" font-size="14.00">dd-restart</text>
</g>
<!-- dd&#45;restart&#45;&gt;dd&#45;start -->
<g id="edge6" class="edge"><title>dd-restart-&gt;dd-start</title>
<path fill="none" stroke="black" d="M75.0034,-216.765C84.0132,-207.624 95.4124,-196.06 105.328,-186"></path>
<polygon fill="black" stroke="black" points="108.031,-188.245 112.558,-178.666 103.045,-183.331 108.031,-188.245"></polygon>
</g>
<!-- dd&#45;stop -->
<g id="node6" class="node"><title>dd-stop</title>
<ellipse fill="none" stroke="black" cx="148" cy="-18" rx="40.0067" ry="18"></ellipse>
<text text-anchor="middle" x="148" y="-13.8" font-family="Times,serif" font-size="14.00">dd-stop</text>
</g>
<!-- dd&#45;restart&#45;&gt;dd&#45;stop -->
<g id="edge4" class="edge"><title>dd-restart-&gt;dd-stop</title>
<path fill="none" stroke="black" d="M61.6053,-216.012C64.6168,-197.91 70.1819,-168.538 78,-144 88.5767,-110.804 91.6743,-102.227 109,-72 114.683,-62.0856 121.879,-51.827 128.539,-43.007"></path>
<polygon fill="black" stroke="black" points="131.343,-45.1014 134.692,-35.0497 125.806,-40.8193 131.343,-45.1014"></polygon>
</g>
<!-- dd&#45;rebuild -->
<g id="node8" class="node"><title>dd-rebuild</title>
<ellipse fill="none" stroke="black" cx="447" cy="-306" rx="50.8955" ry="18"></ellipse>
<text text-anchor="middle" x="447" y="-301.8" font-family="Times,serif" font-size="14.00">dd-rebuild</text>
</g>
<!-- dd&#45;image&#45;rebuild -->
<g id="node10" class="node"><title>dd-image-rebuild</title>
<ellipse fill="none" stroke="black" cx="447" cy="-234" rx="78.1126" ry="18"></ellipse>
<text text-anchor="middle" x="447" y="-229.8" font-family="Times,serif" font-size="14.00">dd-image-rebuild</text>
</g>
<!-- dd&#45;rebuild&#45;&gt;dd&#45;image&#45;rebuild -->
<g id="edge8" class="edge"><title>dd-rebuild-&gt;dd-image-rebuild</title>
<path fill="none" stroke="black" d="M447,-287.697C447,-279.983 447,-270.712 447,-262.112"></path>
<polygon fill="black" stroke="black" points="450.5,-262.104 447,-252.104 443.5,-262.104 450.5,-262.104"></polygon>
</g>
<!-- dd&#45;image&#45;remove -->
<g id="node12" class="node"><title>dd-image-remove</title>
<ellipse fill="none" stroke="red" cx="393" cy="-162" rx="79.5167" ry="18"></ellipse>
<text text-anchor="middle" x="393" y="-157.8" font-family="Times,serif" font-size="14.00">dd-image-remove</text>
</g>
<!-- dd&#45;image&#45;rebuild&#45;&gt;dd&#45;image&#45;remove -->
<g id="edge10" class="edge"><title>dd-image-rebuild-&gt;dd-image-remove</title>
<path fill="none" stroke="black" d="M433.928,-216.055C427.428,-207.629 419.444,-197.28 412.26,-187.966"></path>
<polygon fill="black" stroke="black" points="414.831,-185.569 405.952,-179.789 409.288,-189.845 414.831,-185.569"></polygon>
</g>
<!-- dd&#45;image&#45;rebuild&#45;&gt;dd&#45;image&#45;build -->
<g id="edge12" class="edge"><title>dd-image-rebuild-&gt;dd-image-build</title>
<path fill="none" stroke="black" d="M461.4,-216.105C468.828,-206.264 477.125,-193.218 481,-180 485.501,-164.646 482.746,-159.904 481,-144 477.423,-111.415 480.637,-100.81 465,-72 459.055,-61.0468 450.184,-50.8077 441.445,-42.3054"></path>
<polygon fill="black" stroke="black" points="443.594,-39.5259 433.876,-35.3065 438.842,-44.6654 443.594,-39.5259"></polygon>
</g>
<!-- dd&#45;remove -->
<g id="node18" class="node"><title>dd-remove</title>
<ellipse fill="none" stroke="black" cx="283" cy="-90" rx="52.2998" ry="18"></ellipse>
<text text-anchor="middle" x="283" y="-85.8" font-family="Times,serif" font-size="14.00">dd-remove</text>
</g>
<!-- dd&#45;image&#45;remove&#45;&gt;dd&#45;remove -->
<g id="edge16" class="edge"><title>dd-image-remove-&gt;dd-remove</title>
<path fill="none" stroke="black" d="M367.487,-144.765C352.065,-134.95 332.251,-122.341 315.687,-111.801"></path>
<polygon fill="black" stroke="black" points="317.184,-108.605 306.868,-106.189 313.426,-114.511 317.184,-108.605"></polygon>
</g>
<!-- dd&#45;build -->
<g id="node15" class="node"><title>dd-build</title>
<ellipse fill="none" stroke="black" cx="413" cy="-90" rx="43.1449" ry="18"></ellipse>
<text text-anchor="middle" x="413" y="-85.8" font-family="Times,serif" font-size="14.00">dd-build</text>
</g>
<!-- dd&#45;build&#45;&gt;dd&#45;image&#45;build -->
<g id="edge14" class="edge"><title>dd-build-&gt;dd-image-build</title>
<path fill="none" stroke="black" d="M413,-71.6966C413,-63.9827 413,-54.7125 413,-46.1124"></path>
<polygon fill="black" stroke="black" points="416.5,-46.1043 413,-36.1043 409.5,-46.1044 416.5,-46.1043"></polygon>
</g>
<!-- dd&#45;remove&#45;&gt;dd&#45;stop -->
<g id="edge18" class="edge"><title>dd-remove-&gt;dd-stop</title>
<path fill="none" stroke="black" d="M255.355,-74.6655C234.202,-63.6971 204.912,-48.51 182.27,-36.7695"></path>
<polygon fill="black" stroke="black" points="183.817,-33.6292 173.328,-32.1331 180.595,-39.8435 183.817,-33.6292"></polygon>
</g>
<!-- dd&#45;recreate -->
<g id="node20" class="node"><title>dd-recreate</title>
<ellipse fill="none" stroke="black" cx="241" cy="-162" rx="54.1829" ry="18"></ellipse>
<text text-anchor="middle" x="241" y="-157.8" font-family="Times,serif" font-size="14.00">dd-recreate</text>
</g>
<!-- dd&#45;recreate&#45;&gt;dd&#45;create -->
<g id="edge22" class="edge"><title>dd-recreate-&gt;dd-create</title>
<path fill="none" stroke="black" d="M223.373,-144.765C213.423,-135.6 200.826,-123.998 189.883,-113.919"></path>
<polygon fill="black" stroke="black" points="191.996,-111.106 182.269,-106.906 187.254,-116.255 191.996,-111.106"></polygon>
</g>
<!-- dd&#45;recreate&#45;&gt;dd&#45;remove -->
<g id="edge20" class="edge"><title>dd-recreate-&gt;dd-remove</title>
<path fill="none" stroke="black" d="M251.167,-144.055C256.12,-135.801 262.179,-125.701 267.677,-116.538"></path>
<polygon fill="black" stroke="black" points="270.783,-118.165 272.927,-107.789 264.78,-114.563 270.783,-118.165"></polygon>
</g>
<!-- dd&#45;start&#45;logs -->
<g id="node24" class="node"><title>dd-start-logs</title>
<ellipse fill="none" stroke="blue" cx="219" cy="-306" rx="59.267" ry="18"></ellipse>
<text text-anchor="middle" x="219" y="-301.8" font-family="Times,serif" font-size="14.00">dd-start-logs</text>
</g>
<!-- dd&#45;start&#45;logs&#45;&gt;dd&#45;start -->
<g id="edge26" class="edge"><title>dd-start-logs-&gt;dd-start</title>
<path fill="none" stroke="black" d="M222.456,-287.917C225.347,-268.94 227.149,-238.07 214,-216 203.775,-198.838 185.623,-186.455 168.623,-177.997"></path>
<polygon fill="black" stroke="black" points="169.899,-174.73 159.354,-173.696 166.952,-181.08 169.899,-174.73"></polygon>
</g>
<!-- dd&#45;logs -->
<g id="node27" class="node"><title>dd-logs</title>
<ellipse fill="none" stroke="black" cx="165" cy="-234" rx="40.0067" ry="18"></ellipse>
<text text-anchor="middle" x="165" y="-229.8" font-family="Times,serif" font-size="14.00">dd-logs</text>
</g>
<!-- dd&#45;start&#45;logs&#45;&gt;dd&#45;logs -->
<g id="edge28" class="edge"><title>dd-start-logs-&gt;dd-logs</title>
<path fill="none" stroke="black" d="M206.203,-288.411C199.545,-279.781 191.277,-269.062 183.898,-259.497"></path>
<polygon fill="black" stroke="black" points="186.585,-257.25 177.705,-251.47 181.042,-261.526 186.585,-257.25"></polygon>
</g>
<!-- dd&#45;restart&#45;logs -->
<g id="node28" class="node"><title>dd-restart-logs</title>
<ellipse fill="none" stroke="black" cx="67" cy="-306" rx="67.0185" ry="18"></ellipse>
<text text-anchor="middle" x="67" y="-301.8" font-family="Times,serif" font-size="14.00">dd-restart-logs</text>
</g>
<!-- dd&#45;restart&#45;logs&#45;&gt;dd&#45;restart -->
<g id="edge30" class="edge"><title>dd-restart-logs-&gt;dd-restart</title>
<path fill="none" stroke="black" d="M65.0225,-287.697C64.1409,-279.983 63.0814,-270.712 62.0986,-262.112"></path>
<polygon fill="black" stroke="black" points="65.5677,-261.642 60.9548,-252.104 58.613,-262.437 65.5677,-261.642"></polygon>
</g>
<!-- dd&#45;restart&#45;logs&#45;&gt;dd&#45;logs -->
<g id="edge32" class="edge"><title>dd-restart-logs-&gt;dd-logs</title>
<path fill="none" stroke="black" d="M89.7295,-288.765C103.531,-278.906 121.281,-266.228 136.078,-255.659"></path>
<polygon fill="black" stroke="black" points="138.293,-258.377 144.396,-249.717 134.225,-252.681 138.293,-258.377"></polygon>
</g>
</g>
</svg>
- info
  ```bash
  $ dd-info
  +=======================================+
  | Entering project DOCKUTILS.GIT at /home/vagrant/data/work2/dockutils.git ...
  |
  | NAME       = my-hello-world
  | VERSION    = 0.3
  | IMAGE      = mylocal/my-hello-world:0.3
  | HOST       = <none> - optional for build-only components
  | REPOSITORY = mylocal/
  | NETWORK_NAME = <missing>
  |
  | PORTS
  |   EXTERNAL_HTTP_PORT=8080
  |   HTTP_PORT=8080
  | DESCRIPTION
  |
  |   A demo of dockerutils.
  |
  | DIR=/home/vagrant/data/work2/dockutils.git
  | BASEDIR=/home/vagrant/data/work2/dockutils.git
  | TARGET=
  |
  |------------------------------------------------
  | For pull/push to external repository
  |
  | EXTERNAL_REPOSITORY = registry.gitlab.com/raisercostin/docker2/
  | EXTERNAL_IMAGE      = registry.gitlab.com/raisercostin/docker2/my-hello-world:0.3
  |------------------------------------------------
  | Available commands:
  |   dd-attention-clean
  |   dd-attention-clean-system
  |   dd-build
  |   dd-clean-orphan
  |   dd-create
  |   dd-export-to-file
  |   dd-export-to-repository
  |   dd-image-build
  |   dd-image-rebuild
  |   dd-image-release-in-progress
  |   dd-image-remove
  |   dd-import-from-file
  |   dd-import-from-repository
  |   dd-info
  |   dd-logs
  |   dd-rebuild
  |   dd-recreate
  |   dd-remove
  |   dd-restart
  |   dd-restart-logs
  |   dd-run
  |   dd-shell
  |   dd-shell-root
  |   dd-simple-create
  |   dd-start
  |   dd-start-logs
  |   dd-stop
  |   dd-tree
  +=======================================+
  ```
  