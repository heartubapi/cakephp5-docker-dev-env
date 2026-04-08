ARG PHP_VERSION=8.3
FROM shinsenter/cakephp5:php${PHP_VERSION}

ENV TZ=America/Mexico_City
ENV PUID=1000
ENV PGID=1000

# Install Xdebug
RUN phpaddmod xdebug

# Xdebug configuration (sin zend_extension porque phpaddmod ya lo carga)
RUN echo "[xdebug]" > /usr/local/etc/php/conf.d/99-xdebug-custom.ini && \
    echo "xdebug.mode=develop,debug" >> /usr/local/etc/php/conf.d/99-xdebug-custom.ini && \
    echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/99-xdebug-custom.ini && \
    echo "xdebug.client_port=9003" >> /usr/local/etc/php/conf.d/99-xdebug-custom.ini && \
    echo "xdebug.start_with_request=trigger" >> /usr/local/etc/php/conf.d/99-xdebug-custom.ini && \
    echo "xdebug.idekey=PHPSTORM" >> /usr/local/etc/php/conf.d/99-xdebug-custom.ini && \
    echo "xdebug.log_level=0" >> /usr/local/etc/php/conf.d/99-xdebug-custom.ini

# Custom PHP settings
RUN echo "[PHP]" > /usr/local/etc/php/conf.d/99-custom.ini && \
    echo "memory_limit=512M" >> /usr/local/etc/php/conf.d/99-custom.ini && \
    echo "upload_max_filesize=128M" >> /usr/local/etc/php/conf.d/99-custom.ini && \
    echo "post_max_size=128M" >> /usr/local/etc/php/conf.d/99-custom.ini && \
    echo "max_execution_time=300" >> /usr/local/etc/php/conf.d/99-custom.ini && \
    echo "max_input_time=300" >> /usr/local/etc/php/conf.d/99-custom.ini && \
    echo "display_errors=On" >> /usr/local/etc/php/conf.d/99-custom.ini && \
    echo "error_reporting=E_ALL" >> /usr/local/etc/php/conf.d/99-custom.ini

WORKDIR /var/www/html