ARG MDSPLUS_FLAVOR=alpha

FROM whobrokethebuild/mdsplus:${MDSPLUS_FLAVOR}
LABEL maintainer="Stephen Lane-Walsh <slw@psfc.mit.edu>"

COPY mdsip.hosts /etc/mdsip.hosts
COPY entrypoint.sh /entrypoint.sh

EXPOSE 8200

ENTRYPOINT ["/entrypoint.sh"]