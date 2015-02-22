#!/usr/bin/env bash

# needed for java 8
add-apt-repository ppa:webupd8team/java

# Update repositories
apt-get update

# PHP tools
apt-get install -y php5-xdebug php5-xmlrpc php5-memcached memcached mc oracle-java8-installer

#install java 8
echo -e oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
echo -e \\033c

apt-get install -y oracle-java8-set-default

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

URL='https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.4.deb'; FILE=`mktemp`; wget "$URL" -qO $FILE && dpkg -i $FILE; rm $FILE

# Finally, restart apache
service apache2 restart
