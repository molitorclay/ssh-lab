FROM busybox:1.35


RUN adduser -D www
USER www
WORKDIR /home/www

COPY ./$SELF/web .

# Run BusyBox httpd
CMD ["busybox", "httpd", "-f", "-v", "-p", "3000"]

