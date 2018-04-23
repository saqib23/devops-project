#!/bin/bash

SCRIPT_HOME=$( cd "$(dirname "$0")" ; pwd -P )
CONF_FILE=$SCRIPT_HOME/configuration.cfg
source $CONF_FILE
SSL_PARAMS_LOCAL_CONF=$SCRIPT_HOME/ssl-params-local.conf
SELF_SIGNED_LOCAL_CONF=$SCRIPT_HOME/self-signed-local.conf
NGINX_LOCAL_DEFAULT_CONF=$SCRIPT_HOME/nginx-local-default.conf
NGINX_LOCAL_DEFAULT_BAK_CONF=$SCRIPT_HOME/nginx-local-default-bak.conf
DEFAULT_HTML_FILE=$SCRIPT_HOME/index.html
#Update packages and upgrade system
sudo apt-get update -y && sudo apt-get upgrade -y

#Install Nginx
sudo apt-get install nginx -y

#activate SSL Module
sudo a2enmod ssl
#Restart Nginx service
sudo systemctl restart nginx

#Configure Nginx to Use SSL
openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 \
    -subj "/C=$Country_Name/ST=$State_Name/L=$City_Name/O=$Org_Name/OU=$Dept_Name/CN=$FQDN/emailAddress=$Email" \
    -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
#Creating Strong strong Diffie-Hellman group
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
cat /dev/null > /etc/nginx/snippets/self-signed.conf
cat $SELF_SIGNED_LOCAL_CONF >  /etc/nginx/snippets/self-signed.conf
cat /dev/null > /etc/nginx/snippets/ssl-params.conf
cat $SSL_PARAMS_LOCAL_CONF > /etc/nginx/snippets/ssl-params.conf

sed -i "s|server_name.*com;|server_name $FQDN;|" $NGINX_LOCAL_DEFAULT_CONF
sed -i "s|root.*;|root $DocumentRoot;|" $NGINX_LOCAL_DEFAULT_CONF
#Congiguring Nginx default conf with our server name and web content path from configuration file
cat /dev/null > $NGINX_DEFAULT_CONF
cat $NGINX_LOCAL_DEFAULT_CONF > $NGINX_DEFAULT_CONF
#Reverting the changes in local default file
cat /dev/null > $NGINX_LOCAL_DEFAULT_CONF
cat $NGINX_LOCAL_DEFAULT_BAK_CONF > $NGINX_LOCAL_DEFAULT_CONF

cat /dev/null > $DocumentRoot/index.html
cat $DEFAULT_HTML_FILE > $DocumentRoot/index.html
#Saving the changes
sudo nginx -t
sudo systemctl restart nginx
