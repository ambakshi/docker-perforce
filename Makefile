.PHONY: image clean tag push

DOCKER_REPO=ambakshi
IMAGES=perforce-base perforce-proxy perforce-server perforce-git-fusion \
	   perforce-swarm perforce-sampledepot

all: image

perforce-proxy-image: perforce-base-tag
perforce-server-image: perforce-base-tag
perforce-proxy-image: perforce-base
perforce-git-fusion-image: perforce-server-tag
perforce-sampledepot-image: perforce-server-tag
perforce-swarm-image: perforce-base-tag

%/id_rsa.pub: id_rsa.pub
	cp $< $@

id_rsa:
	ssh-keygen -q -f $@ -N ""

id_rsa.pub: id_rsa
	ssh-keygen -y -f $< > $@

define DOCKER_build

.PHONY: $(DOCKER_REPO)/$(1) $(1)-clean

image: $(DOCKER_REPO)/$(1)
clean: $(1)-clean

$(DOCKER_REPO)/$(1): $(1)/Dockerfile
	@echo "===================="
	@echo "Building $(DOCKER_REPO)/$(1) ..."
	@echo " --> docker build -t $(DOCKER_REPO)/$(1) $(1)"
	@docker build -t $(DOCKER_REPO)/$(1) $(1)

$(1)-clean:
	docker rmi $(DOCKER_REPO)/$(1)

endef

$(foreach image,$(IMAGES),$(eval $(call DOCKER_build,$(image))))

