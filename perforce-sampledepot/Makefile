.PHONY: all build run push

IMAGE=perforce-sampledepot
NAME=perforce
HOST=perforce.localdomain

all: build

build:
	docker build -t $(IMAGE)

push: build
	docker push $(IMAGE)

run: build
	docker run -d -v /data --name P4ROOT busybox /bin/true || /bin/true
	docker run -ti --volumes-from P4ROOT -d --name $(NAME) -h $(HOST) -p 1666:1666 $(IMAGE)
