#!/bin/bash

echo 'Starting...'

CONFIG_FILE=configs/cert_gen_config.cfg
if [ -f $CONFIG_FILE ]; then
	echo "Loading config $CONFIG_FILE"
	source $CONFIG_FILE
else
	echo "*** Config file '$CONFIG_FILE' is missing ***"
  	exit 1
fi


currentUser=$(whoami)
if [ $currentUser != "root" ]
then
  echo "*** You are running script as $currentUser. Please re-run the script as root ***"
  exit 1
else
	echo "User permissions sattisfied"
fi


if [ ${DOMAINS_CSV+x} ]; then
	DOMAINS_LIST="-d ${DOMAINS_CSV//\,/\ -d }"
else
	echo "*** There are no domains in the config file. Please specify DOMAINS_CSV with comma separated domain names. DOMAINS_CSV=$DOMAINS_CSV ***"
	exit 1
fi

for CUR_DOMAIN in $DOMAINS_LIST; do
    if [ $CUR_DOMAIN != "-d" ]
	then
	  /bin/bash update_single_domain.sh $CUR_DOMAIN
	fi
done