# Required Tools
DOCKER=/usr/bin/docker
JQ=/usr/bin/jq
AWS=/usr/local/bin/aws

# State Files
STATEFILES=parameters build

# Phony Targets
.PHONY: all run

# Settings
DOCKER_REPO=pts
IMAGE=helix-server
NETWORK=perforce
NAME=p4d
HOST=p4d.c7-titan.localdomain

# Default Target
all: parameters build

# Create/Update SSM Parameters
parameters: ssm-parameters.json
	$(JQ) -c -M '.Parameters | .[]' ssm-parameters.json | sed -e 's/"/\\"/g' \
		| xargs -i $(AWS) ssm put-parameter --cli-input-json {}
	@touch parameters

# Build Docker Image
build: parameters Dockerfile
	$(DOCKER) build -t $(DOCKER_REPO)/$(IMAGE) .
	@touch build

# Run Docker Container
run: build
	-$(DOCKER) run -d --volume /data --name P4ROOT busybox /bin/true 2>/dev/null
	$(DOCKER) run -ti --volumes-from P4ROOT -d --network $(NETWORK) --name $(NAME) \
		--hostname $(HOST) --publish 1666:1666 $(DOCKER_REPO)/$(IMAGE)

# Clean things up
clean:
	-$(DOCKER) rm -f $(NAME) 2>/dev/null
	-rm $(STATEFILES)
	-$(JQ) -c -M '.Parameters | .[].Name' ssm-parameters.json \
		| xargs -i $(AWS) ssm delete-parameter --name {}

#
# End
