FROM jelastic/apachephp

COPY typo3_src-8.7.2.tar.gz /var/www/webroot
COPY docker_typo3.sh /tmp/
RUN sh /tmp/docker_typo3.sh
