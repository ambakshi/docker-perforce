.PHONY: all build run

IMAGE=perforce-swarm
NAME=perforce-swarm
HOST=perforce-swarm.c7-titan.localdomain

all: build

build:
	docker build -t $(IMAGE) .

run: build
	-docker rm -f $(NAME) 2>/dev/null
	docker run -d -ti --link perforce:perforce -p 80:80 -h $(HOST) --name $(NAME) $(IMAGE)
