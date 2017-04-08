dogstatsd:
	docker run --rm --name dogstatsd -p 8125:8125/udp -ti appropriate/nc -kluvw 0 0.0.0.0 8125

start:
	docker build . -t fluent-ext
	docker run --link dogstatsd:dogstatsd -e DOGSTATSD_PORT=8125 -e DOGSTATSD_HOST=dogstatsd -e CORS_ALLOW_ORIGINS=http://localhost:8000 -ti -p 8888:8888 fluent-ext -vv

shell:
	docker build . -t fluent-ext
	docker run --link dogstatsd:dogstatsd -ti --entrypoint sh fluent-ext

nc:
	(echo "hello world!" && date) | nc -vuw 0 127.0.0.1 8125

curl:
	curl -vvv -D - -X POST -H "Origin: http://localhost:8000" -d 'json={"type": "gauge", "key": "xxx.yyy", "value": 66262, "tags": {"url": "abcdefg"}}' http://localhost:8888/

curl-multi:
	curl -D - -X POST -d 'json=[{"type": "count", "key": "aaa.bbb", "value": 101, "tags": {"url": "abcdefg"}},{"type": "count", "key": "cccc.dddd", "value": 11, "tags": {"url": "abcdefg"}}]' http://localhost:8888/

shs:
	python -mSimpleHTTPServer