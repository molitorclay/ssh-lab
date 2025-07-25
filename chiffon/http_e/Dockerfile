# HTTP_E
FROM busybox:1.37

ARG SELF
ARG WWWUSER="www"
ARG WWWDIR="/home/www"

RUN adduser -D www
USER www
WORKDIR $WWWDIR


COPY ./$SELF/web .
COPY --chown=$WWWUSER:$WWWUSER ./ssh_f/ssh/id_ed25519 ./index.html

CMD ["busybox", "httpd", "-f", "-v", "-p", "80"]

