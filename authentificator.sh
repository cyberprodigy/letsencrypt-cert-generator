#!/bin/bash

CONFIG_FILE=configs/cert_gen_config.cfg
if [ -f $CONFIG_FILE ]; then
	echo "Loading config $CONFIG_FILE"
	source $CONFIG_FILE
else
	echo "*** Config file '$CONFIG_FILE' is missing ***"
  	exit 1
fi

if [ -z ${DOCUMENT_ROOTS[$CERTBOT_DOMAIN]}  ]; then
	echo "Could not find entry in your config for domain $CERTBOT_DOMAIN. Please specify entry in $CONFIG_FILE"
	exit 1
else
	echo "Found entry for $CERTBOT_DOMAIN. Will work in ${DOCUMENT_ROOTS[$CERTBOT_DOMAIN]}"
fi

echo $CERTBOT_VALIDATION>$CERTBOT_TOKEN


ftp -inv $FTP_HOST << EOF

# login credentials are supplied by calling the variables.

user ${FTP_USER} ${FTP_PASS}

pwd

cd ${DOCUMENT_ROOTS[$CERTBOT_DOMAIN]}

pwd

mkdir ".well-known"

pwd

cd ".well-known"

pwd

mkdir "acme-challenge"

pwd

cd "acme-challenge"

pwd

put $CERTBOT_TOKEN

ls

bye

EOF