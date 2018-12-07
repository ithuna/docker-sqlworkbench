#!/bin/sh
set -e

# FUNCTION: sync_dir()
# ARGUMENTS:
# $1: Source directory
# $2: destination directory
# copy any missing files from our /usr/local/share/sqlworkbench folder
# to our /app folder
sync_dir() 
{
	for f in `ls $1`
	do
		if ! cmp -s $1/$f $2/$f; then
      echo "Replacing missing or damaged file: ${2}/${f}"
      cp $1/$f $2/$f
		fi
	done
}

sync_dir $SQLWB_SHARE_DIR/config $SQLWB_APP_DIR/config
sync_dir $SQLWB_SHARE_DIR/sql $SQLWB_APP_DIR/sql

exec "$@"
