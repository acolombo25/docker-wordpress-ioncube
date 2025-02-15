FROM wordpress
MAINTAINER Andrea Colombo <acolombodev@gmail.com>

# Increase Upload and Memory Limit
RUN echo "file_uploads = On\n" \
         "memory_limit = 512M\n" \
         "upload_max_filesize = 128M\n" \
         "post_max_size = 128M\n" \
         "max_execution_time = 600\n" \
         > /usr/local/etc/php/conf.d/custom-limits.ini

# Increase Memory Limit for Wordpress
RUN sed \
	-i "/MySQL settings/idefine( 'WP_MEMORY_LIMIT', '256M' );" \
	/usr/src/wordpress/wp-config-sample.php

# Install ioncube
ADD https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz /tmp/
RUN tar xvzfC /tmp/ioncube_loaders_lin_x86-64.tar.gz /tmp/ && \
	php_ext_dir="$(php -i | grep extension_dir | head -n1 | awk '{print $3}')" && \
    php_ver=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;") && \
	mv /tmp/ioncube/ioncube_loader_lin_${php_ver}.so "${php_ext_dir}/" && \
    echo "zend_extension = $php_ext_dir/ioncube_loader_lin_${php_ver}.so" \
        > /usr/local/etc/php/conf.d/00-ioncube.ini && \
	rm /tmp/ioncube_loaders_lin_x86-64.tar.gz && \
	rm -rf /tmp/ioncube
