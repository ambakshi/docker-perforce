.PHONY: image clean tag push

DOCKER_REPO=ambakshi
IMAGES=perforce-base perforce-server perforce-git-fusion \
	   perforce-swarm perforce-sampledepot

all: id_rsa.pub image

perforce-git-fusion-image: perforce-git-fusion/id_rsa.pub

%/id_rsa.pub: id_rsa.pub
	cp $< $@

id_rsa:
	ssh-keygen -q -f $@ -N ""

id_rsa.pub: id_rsa
	ssh-keygen -y -f $< > $@

define DOCKER_build

.PHONY: $(1) $(1)-image $(1)-tag $(1)-push $(1)-clean

image: $(1)-image
tag: $(1)-tag
push: $(1)-push
clean: $(1)-clean

$(1)-image:
	@echo "===================="
	@echo "Building $(1) ..."
	@echo " --> docker build -t $(1) $(1)"
	@docker build -t $(1) $(1)

$(1)-tag:
	docker tag -f $(1):latest $(DOCKER_REPO)/$(1):latest

$(1)-push: $(1)-tag
	docker push $(DOCKER_REPO)/$(1):latest

$(1)-clean:
	docker rmi $(1)

endef

$(foreach image,$(IMAGES),$(eval $(call DOCKER_build,$(image))))

