#!/usr/bin/env bash

# Update repositories
apt-get update

# Special Setup for phpmyadmin
DBPASSWD=root #has to match scotchbox default which is root
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password $DBPASSWD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password $DBPASSWD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password $DBPASSWD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none" | debconf-set-selections

# PHP tools
apt-get install -y php5-xdebug php5-intl php5-xmlrpc mc default-jre default-jdk phpmyadmin

echo "; xdebug
xdebug.remote_connect_back = 1
xdebug.remote_enable = 1
xdebug.remote_handler = \"dbgp\"
xdebug.remote_port = 9000
xdebug.var_display_max_children = 512
xdebug.var_display_max_data = 1024
xdebug.var_display_max_depth = 10
xdebug.idekey = \"PHPSTORM\"" >> /etc/php5/apache2/php.ini

#PHPMYADMIN
mv /etc/phpmyadmin/apache.conf /etc/apache2/sites-available/phpmyadmin.conf
a2ensite phpmyadmin

a2enmod vhost_alias

# Add another place for vhost configuration (so we can keep these in our repo)
echo "IncludeOptional /var/www/vhosts/*.conf" >> /etc/apache2/apache2.conf

# Finally, restart apache
service apache2 restart
