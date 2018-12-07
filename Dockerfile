FROM openjdk:8-alpine
LABEL maintainer "Chris Wells <chris@cevanwells.com>"

RUN apk add --update \
		curl \
		ca-certificates \
		unzip \
	&& rm -rf /var/cache/apk/*

ENV SQLWORKBENCH_VERSION=Build124
ENV SQLWORKBENCH_SRC_URL="https://www.sql-workbench.eu/Workbench-${SQLWORKBENCH_VERSION}.zip"

WORKDIR /app
RUN mkdir exports config sql lib bin \
    && mkdir -p /usr/local/share/sqlworkbench/config \
                /usr/local/share/sqlworkbench/sql

RUN curl -sSL "${SQLWORKBENCH_SRC_URL}" -o "sqlworkbench-${SQLWORKBENCH_VERSION}.zip" \
	&& unzip -q "sqlworkbench-${SQLWORKBENCH_VERSION}.zip" -d /app/bin \
	&& chmod +x /app/bin/sqlwbconsole.sh \
	&& rm -f "sqlworkbench-${SQLWORKBENCH_VERSION}.zip" 

# Install PostgreSQL JDBC driver
RUN curl -sSL http://central.maven.org/maven2/org/postgresql/postgresql/9.2-1003-jdbc4/postgresql-9.2-1003-jdbc4.jar \
		 -o jdbc-postgresql.jar \
	&& mv jdbc-postgresql.jar lib/

# Install MariaDB (mysql) JDBC driver
RUN curl -sSL http://central.maven.org/maven2/org/mariadb/jdbc/mariadb-java-client/2.3.0/mariadb-java-client-2.3.0.jar \
		 -o jdbc-mariadb.jar \
	&& mv jdbc-mariadb.jar lib/

# Install MSSQL JDBC driver
RUN curl -sSL https://github.com/Microsoft/mssql-jdbc/releases/download/v7.1.3/mssql-jdbc-7.1.3.jre8-preview.jar \
		 -o jdbc-mssql.jar \
	&& mv jdbc-mssql.jar lib/

COPY bin/* /usr/local/bin/
COPY config/* /usr/local/share/sqlworkbench/config/
COPY sql/* /usr/local/share/sqlworkbench/sql/

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
