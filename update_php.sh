#!/bin/sh
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum -y install yum-plugin-replace php-common
yum -y replace php-common --replace-with=php71w-common
yum -y install php71w php71w-opcache php71w-gd php71w-mbstring php71w-mcrypt php71w-pdo php71w-soap php71w-xml php71w-bcmath
yum -y install php71w-interbase php71w-dba php71w-mysqlnd php71w-common php71w-cli php71w-pgsql php71w-process php71w-tidy php71w-xml
mv /etc/php.ini /etc/php.ini.back
mv /etc/php.ini.rpmnew /etc/php.ini
sed -i 's/# LoadModule foo_module modules\/mod_foo.so/LoadModule php7_module \/etc\/httpd\/modules\/libphp7.so/g' /etc/httpd/conf/httpd.conf
