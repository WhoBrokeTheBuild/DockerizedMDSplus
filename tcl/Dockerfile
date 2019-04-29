ARG MDSPLUS_FLAVOR=alpha

FROM whobrokethebuild/mdsplus:${MDSPLUS_FLAVOR}
LABEL maintainer="Stephen Lane-Walsh <slw@psfc.mit.edu>"

COPY entrypoint.sh /entrypoint.sh

ENV TREE default
ENV TREE_SERVER localhost

ENTRYPOINT ["/entrypoint.sh"]