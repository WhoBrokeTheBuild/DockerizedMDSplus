
USER    := whobrokethebuild
REPO    := mdsplus
VERSION ?= $(shell mdstcl show version | grep 'version:' | cut -d ' ' -f 3)

.PHONY: all
all: tree-server mdsip-server

.PHONY: mdsplus
mdsplus: mdsplus-alpha

.PHONY: mdsplus-alpha
mdsplus-alpha:
	cd mdsplus; docker build \
		--build-arg MDSPLUS_FLAVOR=alpha \
		-t ${USER}/${REPO}:alpha .
	docker tag ${USER}/${REPO}:alpha ${USER}/${REPO}:latest
	docker tag ${USER}/${REPO}:alpha ${USER}/${REPO}:${VERSION}

.PHONY: tree-server
tree-server: tree-server-alpha

.PHONY: tree-server-alpha
tree-server-alpha: mdsplus-alpha
	cd tree-server; docker build \
		--build-arg MDSPLUS_FLAVOR=alpha \
		-t ${USER}/${REPO}:tree-server-alpha .
	docker tag ${USER}/${REPO}:tree-server-alpha ${USER}/${REPO}:tree-server
	docker tag ${USER}/${REPO}:tree-server-alpha ${USER}/${REPO}:${VERSION}-tree-server

.PHONY: mdsip-server
mdsip-server: mdsip-server-alpha

.PHONY: mdsip-server-alpha
mdsip-server-alpha: mdsplus-alpha
	cd mdsip-server; docker build \
		--build-arg MDSPLUS_FLAVOR=alpha \
		-t ${USER}/${REPO}:mdsip-server-alpha .
	docker tag ${USER}/${REPO}:mdsip-server-alpha ${USER}/${REPO}:mdsip-server
	docker tag ${USER}/${REPO}:mdsip-server-alpha ${USER}/${REPO}:${VERSION}-mdsip-server

push:
	docker push ${USER}/${REPO}:latest
	docker push ${USER}/${REPO}:alpha
	docker push ${USER}/${REPO}:tree-server
	docker push ${USER}/${REPO}:tree-server-alpha
	docker push ${USER}/${REPO}:mdsip-server
	docker push ${USER}/${REPO}:mdsip-server-alpha
	docker push ${USER}/${REPO}:${VERSION}
	docker push ${USER}/${REPO}:${VERSION}-tree-server
	docker push ${USER}/${REPO}:${VERSION}-mdsip-server