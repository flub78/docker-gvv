#!/bin/bash
#
# a script to build the gvv container

ERRORS=0;

# Check that required variables are defined
if [ -z ${COMPOSE_PROJECT_NAME+x} ]; 
then 
  echo "\$COMPOSE_PROJECT_NAME is not defined";
  ((++ERRORS))
fi

if [ -z ${REVISION+x} ]; 
then 
  echo "\$REVISION is not defined";
  ((++ERRORS))
fi

if [ -z ${SVN_VERSION+x} ]; 
then 
  echo "\$SVN_VERSION is not defined";
  ((++ERRORS))
fi

if [ -z ${MYSQL_ROOT_PASSWORD+x} ]; 
then 
  echo "\$MYSQL_ROOT_PASSWORD is not defined";
  ((++ERRORS))
fi


# ------------------------------
if ! [ "$ERRORS" -eq "0" ]; then
   echo "Errors detected, Terminating ...";
   exit;
fi

# Environment
echo "building container ...";
echo "COMPOSE_PROJECT_NAME = '$COMPOSE_PROJECT_NAME'";
echo "REVISION = '$REVISION'";
echo "SVN_VERSION = '$SVN_VERSION'";
echo "MYSQL_ROOT_PASSWORD = '$MYSQL_ROOT_PASSWORD'";

# Basic template mechanism
function replace_env {
  SOURCE=$1
	DEST=$2
	cp $SOURCE $DEST
	sed -i "s/\$MYSQL_ROOT_PASSWORD/$MYSQL_ROOT_PASSWORD/g" $DEST
	sed -i "s/\$MYSQL_USER_PASSWORD/$MYSQL_USER_PASSWORD/g" $DEST
	sed -i "s/\$MYSQL_USER_NAME/$MYSQL_USER_NAME/g" $DEST
	echo ""
	# echo $DEST":"
	# cat $DEST
}

# Adapt some files from environment variables
replace_env mysql/create_db.tpl mysql/create_db.sql
replace_env gvv/config/database.tpl gvv/config/database.php
replace_env gvv/config/config.tpl gvv/config/config.php

# Launch the build
docker build \
  --build-arg REVISION="$REVISION" \
  --build-arg SVN_VERSION="$SVN_VERSION" \
  --build-arg MYSQL_ROOT_PASSWORD="$MYSQL_ROOT_PASSWORD" \
  -t flub78/gvv:latest \
  -t flub78/gvv:"$CONTAINER_VERSION" \
  .
