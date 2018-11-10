#!/bin/bash

CONFIG_FILE=configs/cert_gen_config.cfg
if [ -f $CONFIG_FILE ]; then
	echo "Loading config $CONFIG_FILE"
	source $CONFIG_FILE
else
	echo "*** Config file '$CONFIG_FILE' is missing ***"
  	exit 1
fi
echo "Updating $1"
certbot certonly --manual --preferred-challenges=http -n --manual-public-ip-logging-ok --email $EMAIL --agree-tos --manual-auth-hook ./authentificator.sh -d $1 