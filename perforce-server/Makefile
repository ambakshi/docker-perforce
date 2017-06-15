.PHONY: all build run push

DOCKER_REPO=pts
IMAGE=perforce-server
NETWORK=perforce
NAME=perforce
HOST=perforce.c7-titan.localdomain

all: build

build:
	docker build -t $(DOCKER_REPO)/$(IMAGE) .

run: build
	docker run -d --volume /data --name P4ROOT busybox /bin/true 2>/dev/null || /bin/true
	docker run -ti --volumes-from P4ROOT -d --network $(NETWORK) --name $(NAME) \
		--hostname $(HOST) --publish 1666:1666 $(DOCKER_REPO)/$(IMAGE)

clean:
	-docker rm -f $(NAME) 2>/dev/null
