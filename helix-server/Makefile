JQ=/usr/bin/jq

.PHONY: all run

DOCKER_REPO=pts
IMAGE=helix-server
NETWORK=perforce
NAME=p4d
HOST=p4d.c7-titan.localdomain
STATEFILES=parameters build

all: parameters build

parameters: ssm-parameters.json
	$(JQ) -c -M '.Parameters | .[]' ssm-parameters.json | sed -e 's/"/\\"/g' \
		| xargs -i aws ssm put-parameter --cli-input-json {}
	@touch parameters

build: parameters Dockerfile
	docker build -t $(DOCKER_REPO)/$(IMAGE) .
	@touch build

run: build
	-docker run -d --volume /data --name P4ROOT busybox /bin/true 2>/dev/null
	docker run -ti --volumes-from P4ROOT -d --network $(NETWORK) --name $(NAME) \
		--hostname $(HOST) --publish 1666:1666 $(DOCKER_REPO)/$(IMAGE)

clean:
	-docker rm -f $(NAME) 2>/dev/null
	-rm $(STATEFILES)
	-$(JQ) -c -M '.Parameters | .[].Name' ssm-parameters.json \
		| xargs -i aws ssm delete-parameter --name {}
