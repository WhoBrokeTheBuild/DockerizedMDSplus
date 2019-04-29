FROM alpine:3.6
LABEL maintainer="Stephen Lane-Walsh <slw@psfc.mit.edu>"

# Release channel flavor, 'stable' or 'alpha'
ARG MDSPLUS_FLAVOR=alpha

RUN apk add --update wget py-numpy && \
    wget -P /etc/apk/keys/ http://www.mdsplus.org/dist/mdsplus@mdsplus.org-589e05b6.rsa.pub && \
    apk del wget && \
    echo "http://www.mdsplus.org/dist/alpine/3.6/${MDSPLUS_FLAVOR}" >> /etc/apk/repositories && \
    (test "${MDSPLUS_FLAVOR} == alpha" && \
        apk add --update mdsplus-alpha || \
        apk add --update mdsplus) && \
        rm -rf /var/cache/apk/* && \
    echo "mdsip stream tcp nowait root /usr/local/mdsplus/bin/mdsipd mdsip mdsip /var/log/mdsplus/mdsipd" >> /etc/inted.conf

EXPOSE 8000

ENTRYPOINT inetd -fe