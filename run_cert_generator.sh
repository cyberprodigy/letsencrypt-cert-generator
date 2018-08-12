#!/bin/bash
echo 'Starting...'

CONFIG_FILE=enthusiast.cfg
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

DIR=`date +%Y-%m-%d`
mkdir $DIR

echo "Cerificates will be placed in $PWD/$DIR"
echo
echo "Certbot will now ask you to generate files and upload them to the server"
echo "in another terminal window execute the command"
echo "sh upload_acme_verification.sh <file_contents> <path_on_server>"


certbot certonly --manual $DOMAINS_LIST 


cp /etc/letsencrypt/live/enthusiast.io/fullchain.pem $DIR/fullchain.pem
cp /etc/letsencrypt/live/enthusiast.io/privkey.pem $DIR/privkey.pem