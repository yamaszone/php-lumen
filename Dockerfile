FROM ubuntu:16.04

MAINTAINER Mazedur Rahman <mazedur.rahman@sony.com>

# NOTE: vim, ack-grep installed to allow easy editing and should be excluded
# from production image. git needed for lumen-installer.
RUN apt-get update && apt-get install -y \
	ack-grep \
	apache2 \
	curl \
	git \
	php7.0 \
	php7.0-zip \
	vim \
	&& apt-get clean

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer global require "laravel/lumen-installer"
ENV PATH ~/.composer/vendor/bin:$PATH

ENV APACHE_RUN_GROUP www-data
ENV APACHE_RUN_USER www-data

RUN chown -R $APACHE_RUN_USER:$APACHE_RUN_GROUP /var/www \
	&& chmod -R 755 /var/www

RUN /usr/sbin/a2enmod rewrite

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
