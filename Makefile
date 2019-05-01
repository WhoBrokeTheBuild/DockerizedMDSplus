
USER = whobrokethebuild
REPO = mdsplus

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

.PHONY: mdsplus-stable
mdsplus-stable:
	cd mdsplus; docker build \
		--build-arg MDSPLUS_FLAVOR=stable \
		-t ${USER}/${REPO}:stable .

.PHONY: tree-server
tree-server: tree-server-alpha

.PHONY: tree-server-alpha
tree-server-alpha: mdsplus-alpha
	cd tree-server; docker build \
		--build-arg MDSPLUS_FLAVOR=alpha \
		-t ${USER}/${REPO}:tree-server-alpha .
	docker tag ${USER}/${REPO}:tree-server-alpha ${USER}/${REPO}:tree-server

.PHONY: tree-server-stable
tree-server-stable: mdsplus-stable
	cd tree-server; docker build \
		--build-arg MDSPLUS_FLAVOR=stable \
		-t ${USER}/${REPO}:tree-server-stable .

.PHONY: mdsip-server
mdsip-server: mdsip-server-alpha

.PHONY: mdsip-server-alpha
mdsip-server-alpha: mdsplus-alpha
	cd mdsip-server; docker build \
		--build-arg MDSPLUS_FLAVOR=alpha \
		-t ${USER}/${REPO}:mdsip-server-alpha .
	docker tag ${USER}/${REPO}:mdsip-server-alpha ${USER}/${REPO}:mdsip-server

.PHONY: mdsip-server-stable
mdsip-server-stable: mdsplus-stable
	cd mdsip-server; docker build \
		--build-arg MDSPLUS_FLAVOR=stable \
		-t ${USER}/${REPO}:mdsip-server-stable .
