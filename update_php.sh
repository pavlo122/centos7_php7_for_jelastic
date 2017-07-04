#!/bin/sh
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum -y install yum-plugin-replace php-common
yum -y replace php-common --replace-with=php70w-common
yum -y install php70w php70w-opcache php70w-gd php70w-mbstring php70w-mcrypt php70w-pdo php70w-soap php70w-xml php70w-bcmath
yum -y install php70w-interbase php70w-dba php70w-mysqlnd php70w-common php70w-cli php70w-pgsql php70w-process php70w-tidy php70w-xml
sed -i 's/# LoadModule foo_module modules\/mod_foo.so/LoadModule php7_module \/etc\/httpd\/modules\/libphp7.so/g' /etc/httpd/conf/httpd.conf
mv /etc/php.ini /etc/php.ini.back
mv /etc/php.ini.rpmnew /etc/php.ini
