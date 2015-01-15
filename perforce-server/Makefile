.PHONY: all build run push

IMAGE=perforce-server
NAME=perforce
HOST=perforce.c7-titan.localdomain

all: build

build:
	docker build -t $(IMAGE) .

run: build
	docker run -d -v /data --name P4ROOT busybox /bin/true 2>/dev/null || /bin/true
	docker run -ti --volumes-from P4ROOT -d --name $(NAME) -h $(HOST) -p 1666:1666 $(IMAGE)
