.PHONY: all build run

IMAGE=pts/helix-client
NETWORK=perforce
NAME=p4
HOST=p4.c7-titan.localdomain

all: build

build:
	docker build -t $(IMAGE) .

run: build
	docker run -it --network $(NETWORK) --name $(NAME) \
		--volume $(shell pwd)/workspace:/root/p4-workspace --hostname $(HOST) \
		$(IMAGE)

clean:
	-docker rm -f $(NAME) 2>/dev/null
