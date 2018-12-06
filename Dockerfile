FROM openjdk:8-alpine
LABEL maintainer "Chris Wells <chris@cevanwells.com>"

RUN apk add --update \
		curl \
		ca-certificates \
		unzip \
	&& rm -rf /var/cache/apk/*

ENV SQLWORKBENCH_VERSION=Build124
ENV SQLWORKBENCH_SRC_URL="https://www.sql-workbench.eu/Workbench-${SQLWORKBENCH_VERSION}.zip"
ENV POSTGRESQL_DRIVER_URL=http://central.maven.org/maven2/org/postgresql/postgresql/9.2-1003-jdbc4/postgresql-9.2-1003-jdbc4.jar

WORKDIR /app
RUN mkdir exports config sql lib bin

RUN curl -sSL "${SQLWORKBENCH_SRC_URL}" -o "sqlworkbench-${SQLWORKBENCH_VERSION}.zip" \
	&& unzip -q "sqlworkbench-${SQLWORKBENCH_VERSION}.zip" -d /app/bin \
	&& chmod +x /app/bin/sqlwbconsole.sh \
	&& rm -f "sqlworkbench-${SQLWORKBENCH_VERSION}.zip" 

RUN curl -sSL "${POSTGRESQL_DRIVER_URL}" -o jdbc-postgresql_driver.jar \
	&& mv jdbc-postgresql_driver.jar lib/

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