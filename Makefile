dogstatsd:
	docker run --link dogstatsd:dogstatsd --name dogstatsd -p 8125:8125/udp -ti appropriate/nc -kluvw 0 0.0.0.0 8125

start:
	docker build . -t fluent-ext
	docker run -ti -p 8888:8888 fluent-ext fluentd -c /fluentd/etc/fluent.conf -vv
	
nc:
	(echo "hello world!" && date) | nc -vuw 0 127.0.0.1 8125
	
curl:
	curl -D - -X POST -d 'json={"type": "increment", "key": "apache.requests", "tags": {"url": "/"}}' http://localhost:8888/