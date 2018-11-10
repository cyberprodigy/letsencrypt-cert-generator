# letsencrypt-cert-generator
This repo contains Linux shell scripts for working with certbot for manually generating certificates. This is useful for web hostings that do not have integration with Letsencrypt, but allows to install certificates by uploading them via control panel (e.x. CPanel and others)

## Instuctions for use

### Make sure you have certbot installed
sudo apt-get install certbot

### Update your config file in
configs/cert_get_config.cfg
Set FTP server credentials
If you have multiple domains hosted on server, come separate them
For each domain add etnry to DOCUMENT_ROOT variable to specify root directory on server for the domain


### Execute scripts
Run these script with root privileges
`sudo bash update_single_domain.sh <domain.com>` to get certificate for one domain
or
`sudo bash update_all_domains.sh` to get certificates for all domains specified in configs


### Upload generated certificates to your server
Then check the logs from cerbot it will produce ssl certificates in folder something like 
/etc/letsencrypt/live/<domain_name>/privkey.pem
/etc/letsencrypt/live/<domain_name>/fullchain.pem

Istall these certificates to your server. See your hosting for options.


### Note
This script accepts all terms of services on your behalf. Read LetsEncrypt TOS to see if you agree.