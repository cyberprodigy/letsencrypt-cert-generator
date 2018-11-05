# letsencrypt-cert-generator
This repo contains Linux shell scripts for working with certbot for manually generating certificates. This is useful for web hostings that do not have integration with Letsencrypt, but allows to install certificates by uploading them via control panel (e.x. CPanel and others)

First make sure you have certbot installed
sudo apt-get install certbot

Then run 
sudo bash ./run_cert_generator.sh
