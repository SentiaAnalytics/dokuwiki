# VERSION 0.1
# AUTHOR:         Soren Jensen <soren@sentia.io>
# DESCRIPTION:    Simple DokuWiki Image
# TO_BUILD:       docker build -t sentia/dokuwiki .
# TO_RUN:         docker run -d -p 8080:80 --name wiki sentia/dokuwiki

# PHP Image with apache installed
FROM php:7-apache

# Update the system and install wget
RUN apt-get update && apt-get upgrade -y wget && rm -rf /var/lib/apt/lists/*

# Copy new apache config over to make dokuwiki the root directory
COPY ./conf/000-default.conf /etc/apache2/sites-enabled/000-default.conf

# Download and Deploy dokuwiki
RUN wget -q "https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz"
RUN tar -zxf dokuwiki-stable.tgz
RUN mv dokuwiki-*/ dokuwiki
RUN rm dokuwiki-stable.tgz

# Fix permissions on dokuwiki for Apache
RUN chown -R www-data:www-data *
