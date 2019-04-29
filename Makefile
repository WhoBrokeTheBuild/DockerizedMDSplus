
USER = whobrokethebuild
REPO = mdsplus

.PHONY: all
all: tree-server daq-server dispatch-server

.PHONY: mdsplus
mdsplus: mdsplus-alpha mdsplus-stable

.PHONY: mdsplus-alpha
mdsplus-alpha:
	cd mdsplus; docker build \
		--build-arg MDSPLUS_FLAVOR=alpha \
		-t ${USER}/${REPO}:alpha .

.PHONY: mdsplus-stable
mdsplus-stable:
	cd mdsplus; docker build \
		--build-arg MDSPLUS_FLAVOR=stable \
		-t ${USER}/${REPO}:stable .

.PHONY: tcl
tcl: tcl-alpha tcl-stable

.PHONY: tcl-alpha
tcl-alpha: mdsplus-alpha
	cd tcl; docker build \
		--build-arg MDSPLUS_FLAVOR=alpha \
		-t ${USER}/${REPO}:tcl-alpha .
	docker tag ${USER}/${REPO}:tcl-alpha ${USER}/${REPO}:tcl

.PHONY: tcl-stable
tcl-stable: mdsplus-stable
	cd tcl; docker build \
		--build-arg MDSPLUS_FLAVOR=stable \
		-t ${USER}/${REPO}:tcl-stable .

.PHONY: tree-server
tree-server: tree-server-alpha tree-server-stable

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
daq-server: daq-server-alpha daq-server-stable

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
dispatch-server: dispatch-server-alpha dispatch-server-stable

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

.PHONY: web-scope
web-scope: web-scope-alpha web-scope-stable

.PHONY: web-scope-alpha
web-scope-alpha: mdsplus-alpha
	cd web-scope; docker build \
		--build-arg MDSPLUS_FLAVOR=alpha \
		-t ${USER}/${REPO}:web-scope-alpha .
	docker tag ${USER}/${REPO}:web-scope-alpha ${USER}/${REPO}:web-scope

.PHONY: web-scope-stable
web-scope-stable: mdsplus-stable
	cd web-scope; docker build \
		--build-arg MDSPLUS_FLAVOR=stable \
		-t ${USER}/${REPO}:web-scope-stable .