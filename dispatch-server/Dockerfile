ARG MDSPLUS_FLAVOR=alpha

FROM whobrokethebuild/mdsplus:${MDSPLUS_FLAVOR}
LABEL maintainer="Stephen Lane-Walsh <slw@psfc.mit.edu>"

COPY entrypoint.sh /entrypoint.sh

EXPOSE 8100

ENTRYPOINT ["/entrypoint.sh"]