FROM jelastic/apachephp

RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
RUN yum -y update
RUN yum -y install yum-plugin-replace
RUN yum -y replace php-common --replace-with=php70w-common
RUN yum -y install php70w php70w-opcache php70w-gd php70w-mbstring php70w-mcrypt php70w-pdo php70w-soap php70w-xml php70w-bcmath
RUN yum -y install php70w-interbase php70w-dba php70w-mysqlnd php70w-common php70w-cli php70w-pgsql php70w-process php70w-tidy php70w-xml
RUN sed -i 's/# LoadModule foo_module modules\/mod_foo.so/LoadModule php7_module \/etc\/httpd\/modules\/libphp7.so/g' /etc/httpd/conf/httpd.conf
RUN mv /etc/php.ini /etc/php.ini.back
RUN mv /etc/php.ini.rpmnew /etc/php.ini
RUN sed -i 's/max_execution_time = 30/max_execution_time = 240/g' /etc/php.ini
RUN sed -i 's/; max_input_vars = 1000/max_input_vars = 1500/g' /etc/php.ini
WORKDIR /var/www/webroot
RUN wget --quiet wget https://netix.dl.sourceforge.net/project/typo3/TYPO3%20Source%20and%20Dummy/TYPO3%208.7.2/typo3_src-8.7.2.tar.gz
RUN tar xfz typo3_src-8.7.2.tar.gz
RUN touch typo3_src-8.7.2/FIRST_INSTALL
WORKDIR /
RUN sed -i 's/webroot\/ROOT/webroot\/typo3_src-8.7.2/g' /etc/httpd/conf/httpd.conf
RUN chown -R apache:apache /var/www/webroot
