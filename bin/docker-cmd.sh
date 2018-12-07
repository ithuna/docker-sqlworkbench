#!/bin/sh
set -e

SQLWB_ARGS=-configDir=$SQLWB_APP_DIR/config
PROFILE=$1
SCRIPT=$2

/usr/local/bin/sqlwbconsole.sh $SQLWB_ARGS -profile=$PROFILE -script=$SQLWB_APP_DIR/sql/$SCRIPT.sql 2>&1