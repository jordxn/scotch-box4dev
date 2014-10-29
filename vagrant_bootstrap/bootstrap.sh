#!/usr/bin/env bash

# Update repositories
apt-get update

# PHP tools
apt-get install -y php5-xdebug php5-xmlrpc mc default-jre 

echo "; xdebug
xdebug.remote_connect_back = 1
xdebug.remote_enable = 1
xdebug.remote_handler = \"dbgp\"
xdebug.remote_port = 9000
xdebug.var_display_max_children = 512
xdebug.var_display_max_data = 1024
xdebug.var_display_max_depth = 10
xdebug.idekey = \"PHPSTORM\"" >> /etc/php5/apache2/php.ini

sed 's#DocumentRoot /var/www/public#DocumentRoot /var/www/app#g' /etc/apache2/sites-available/000-default.conf > /etc/apache2/sites-available/000-default.conf.tmp
mv /etc/apache2/sites-available/000-default.conf.tmp /etc/apache2/sites-available/000-default.conf

URL='https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.13.deb'; FILE=`mktemp`; wget "$URL" -qO $FILE && dpkg -i $FILE; rm $FILE

# Finally, restart apache
service apache2 restart
