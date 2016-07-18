FROM php:7.0-apache

MAINTAINER Mazedur Rahman <mazedur.rahman@sony.com>

RUN apt-get update && apt-get install -y \
	git \
	&& apt-get clean

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer global require "laravel/lumen-installer" \
	&& export PATH="~/.composer/vendor/bin:$PATH"

EXPOSE 80
