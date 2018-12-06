FROM openjdk:8-alpine
LABEL maintainer "Chris Wells <chris@cevanwells.com>"

WORKDIR /app

COPY bin/* /usr/local/bin/

RUN addgroup -S appworker \
	&& adduser -D \
			   -S \
			   -H \
			   -h /app \
			   -G appworker \
			   appworker \
	&& chown appworker:appworker -R /app

USER appworker
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["sh", "-c", "/usr/local/bin/docker-cmd.sh"]