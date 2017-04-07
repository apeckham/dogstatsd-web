start:
	docker build . -t fluent-ext
	docker run -p 8888:8888 -p 24224:24224 -p 24224:24224/udp fluent-ext