
USER = whobrokethebuild
REPO = mdsplus

.PHONY: all
all: tree-server daq-server dispatch-server

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

.PHONY: daq-server
daq-server: daq-server-alpha

.PHONY: daq-server-alpha
daq-server-alpha: mdsplus-alpha
	cd daq-server; docker build \
		--build-arg MDSPLUS_FLAVOR=alpha \
		-t ${USER}/${REPO}:daq-server-alpha .
	docker tag ${USER}/${REPO}:daq-server-alpha ${USER}/${REPO}:daq-server

.PHONY: daq-server-stable
daq-server-stable: mdsplus-stable
	cd daq-server; docker build \
		--build-arg MDSPLUS_FLAVOR=stable \
		-t ${USER}/${REPO}:daq-server-stable .

.PHONY: dispatch-server
dispatch-server: dispatch-server-alpha

.PHONY: dispatch-server-alpha
dispatch-server-alpha: mdsplus-alpha
	cd dispatch-server; docker build \
		--build-arg MDSPLUS_FLAVOR=alpha \
		-t ${USER}/${REPO}:dispatch-server-alpha .
	docker tag ${USER}/${REPO}:dispatch-server-alpha ${USER}/${REPO}:dispatch-server

.PHONY: dispatch-server-stable
dispatch-server-stable: mdsplus-stable
	cd dispatch-server; docker build \
		--build-arg MDSPLUS_FLAVOR=stable \
		-t ${USER}/${REPO}:dispatch-server-stable .
