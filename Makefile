start:
	docker build . -t fluent-ext
	docker run -p 8888:8888 fluent-ext