dogstatsd:
	docker run --name dogstatsd -p 8125:8125/udp -ti appropriate/nc -kluvw 0 0.0.0.0 8125

start:
	docker build . -t fluent-ext
	docker run --link dogstatsd:dogstatsd -ti -p 8888:8888 fluent-ext fluentd -c /fluentd/etc/fluent.conf -vv

nc:
	(echo "hello world!" && date) | nc -vuw 0 127.0.0.1 8125

curl:
	curl -vvv -D - -X POST -d 'json={"type": "count", "key": "xxx.yyy", "value": 101, "tags": {"url": "abcdefg"}}' http://localhost:8888/

curl-multi:
	curl -D - -X POST -d 'json=[{"type": "count", "key": "aaa.bbb", "value": 101, "tags": {"url": "abcdefg"}},{"type": "count", "key": "cccc.dddd", "value": 11, "tags": {"url": "abcdefg"}}]' http://localhost:8888/

shs:
	python -mSimpleHTTPServer