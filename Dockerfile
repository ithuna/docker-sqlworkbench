FROM openjdk:8-alpine
LABEL maintainer "Chris Wells <chris@cevanwells.com>"

COPY bin/* /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["sh", "-c", "/usr/local/bin/docker-cmd.sh"]