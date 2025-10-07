#!/usr/bin/env bash
sudo apt update
sudo apt install apache2 mysql-server php libapache2-mod-php php-mysql -y

sudo mysql -e "CREATE DATABASE wordpress"
sudo mysql -e "CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'password1234321'";
sudo mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

cd /var/www/html/
sudo wget https://wordpress.org/latest.tar.gz
sudo tar -xvzf latest.tar.gz
sudo mv wordpress/* .
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html
sudo rm -rf index.html

sudo cp wp-config-sample.php wp-config.php

sudo sed -i 's/database_name_here/wordpress/' wp-config.php
sudo sed -i 's/username_here/wordpressuser/' wp-config.php
sudo sed -i 's/password_here/password1234321/' wp-config.php

sudo systemctl restart apache2
