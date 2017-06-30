#!/bin/sh
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum -y install yum-plugin-replace php-common
yum -y replace php-common --replace-with=php71w-common
yum -y install php71w php71w-opcache php71w-gd php71w-mbstring php71w-mcrypt php71w-pdo php71w-soap php71w-xml php71w-bcmath
yum -y install php71w-interbase php71w-dba php71w-mysqlnd php71w-common php71w-cli php71w-pgsql php71w-process php71w-tidy php71w-xml
sed -i 's/# LoadModule foo_module modules\/mod_foo.so/LoadModule php7_module \/etc\/httpd\/modules\/libphp7.so/g' /etc/httpd/conf/httpd.conf
mv /etc/php.ini /etc/php.ini.back
mv /etc/php.ini.rpmnew /etc/php.ini
sed -i 's/max_execution_time = 30/max_execution_time = 240/g' /etc/php.ini
sed -i 's/; max_input_vars = 1000/max_input_vars = 1500/g' /etc/php.ini
cd /var/www/webroot
tar xfz typo3_src-8.7.2.tar.gz
touch typo3_src-8.7.2/FIRST_INSTALL
sed -i 's/webroot\/ROOT/webroot\/typo3_src-8.7.2/g' /etc/httpd/conf/httpd.conf
chown -R apache:apache /var/www/webroot
