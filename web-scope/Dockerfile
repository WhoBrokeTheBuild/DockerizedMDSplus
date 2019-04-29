ARG MDSPLUS_FLAVOR=alpha

FROM whobrokethebuild/mdsplus:${MDSPLUS_FLAVOR}
LABEL maintainer="Stephen Lane-Walsh <slw@psfc.mit.edu>"

RUN set -x \
	&& addgroup -g 82 -S www-data \
    && adduser -u 82 -D -S -G www-data www-data \
    && apk add --update apache2 apache2-mod-wsgi

RUN echo "from MDSplus.mdsplus_wsgi import application" > /var/www/localhost/htdocs/mdsplus.wsgi

COPY entrypoint.sh /entrypoint.sh
COPY mdsplus_wsgi_config.py /var/www/localhost/htdocs/mdsplus_wsgi_config.py
COPY mdsplus.conf /etc/apache2/conf.d/mdsplus.conf

ENV SERVER="localhost"

EXPOSE 80

CMD ["/entrypoint.sh"]