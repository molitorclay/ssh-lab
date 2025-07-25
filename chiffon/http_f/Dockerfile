# HTTP_F
FROM busybox:1.37

ARG SELF
ARG WWWUSER="www"
ARG WWWDIR="/home/www"

RUN adduser -D www
USER www
WORKDIR $WWWDIR


#COPY ./$SELF/web .
#COPY --chown=$WWWUSER:$WWWUSER ./ssh_d/ssh/id_ed25519 ./index.html
RUN echo "You Win!" > ./index.html
CMD ["busybox", "httpd"]

