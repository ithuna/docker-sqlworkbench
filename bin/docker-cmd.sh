#!/bin/sh
set -e

SQLWB_ARGS=-configDir=$SQLWB_APP_DIR/config
PROFILE=$1
SCRIPT=$SQLWB_APP_DIR/sql/$2.sql

/usr/local/bin/sqlwbconsole.sh $SQLWB_ARGS -profile=$PROFILE -script=$SCRIPT 2>&1
