#!/bin/bash
apt-get update
apt-get install -y apache2
sed -i -e 's/80/8080/' /etc/apache2/ports.conf
echo "Hello World Sunil Rathod" > /var/www/html/index.html
systemctl restart apache2
apt-get install tree -y
