# to run

In 3 windows:
- `make dogstatsd` runs a fake dogstatsd that echoes what it receives on udp 8125
- `make start` builds docker image and runs fluentd
- `make curl` sends an HTTP request to fluentd, which should eventually show up on the make dogstatsd window

In a 4th window:
- `make shs` runs a simple http server
- `open http://localhost:8000/test.html` opens a test page that sends a beacon to `localhost:8888` (aka make start)