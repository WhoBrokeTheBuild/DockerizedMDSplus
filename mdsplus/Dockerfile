FROM alpine:3.6
LABEL maintainer="Stephen Lane-Walsh <slw@psfc.mit.edu>"

# Release channel flavor, 'stable' or 'alpha'
ARG MDSPLUS_FLAVOR=alpha

RUN apk add --update wget bash py-numpy python \
    && wget -P /etc/apk/keys/ http://www.mdsplus.org/dist/mdsplus@mdsplus.org-589e05b6.rsa.pub \
    && apk del wget \
    && echo "http://www.mdsplus.org/dist/alpine/3.6/${MDSPLUS_FLAVOR}" >> /etc/apk/repositories \
    && apk update \
    && (test "${MDSPLUS_FLAVOR} == alpha" \
        && apk add --update mdsplus-alpha-kernel mdsplus-alpha-python \
        || apk add --update mdsplus-kernel mdsplus-python) \
    && rm -rf /var/cache/apk/*