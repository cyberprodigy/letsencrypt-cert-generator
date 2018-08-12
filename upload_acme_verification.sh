#!/bin/bash

CONFIG_FILE=enthusiast.cfg
if [ -f $CONFIG_FILE ]; then
	echo "Loading config $CONFIG_FILE"
	source $CONFIG_FILE
else
	echo "*** Config file '$CONFIG_FILE' is missing ***"
  	exit 1
fi

DOMAIN=$1
FILE_CONTENTS=$2

IFS='.' read -r -a array <<< "$FILE_CONTENTS"

FILE_NAME=${array[0]}

echo $FILE_CONTENTS>$FILE_NAME

ftp -inv $FTP_HOST << EOF

# Call 2. Here the login credentials are supplied by calling the variables.

user ${FTP_USER} ${FTP_PASS}

cd ${DOCUMENT_ROOTS[$DOMAIN]}

mkdir ".well-known"

cd ".well-known"

mkdir "acme-challenge"

cd "acme-challenge"

put $FILE_NAME


bye

EOF