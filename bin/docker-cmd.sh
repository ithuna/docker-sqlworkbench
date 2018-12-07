#!/bin/sh
set -e

SQLWORKBENCH_ARGS='-jar /app/bin/sqlworkbench.jar -configDir=/app/config'
JAVA_DIR='/usr/bin'
PROFILE="${1}"
SCRIPT="${2}"

$JAVA_DIR/java $SQLWORKBENCH_ARGS -profile=$PROFILE -script="${SCRIPT}.sql" 2>&1