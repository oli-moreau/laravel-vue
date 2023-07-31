FROM debian:12.1

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    apache2 \
    mariadb-server \
    php php-mysql php-mbstring php-xml php-curl \
    nodejs npm \
    unzip

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer

RUN service mariadb start && \
    mysql -e "CREATE DATABASE my_database;" && \
    mysql -e "GRANT ALL PRIVILEGES ON my_database.* TO 'client'@'%' IDENTIFIED BY 'newpassword' WITH GRANT OPTION;" && \
    mysql -e "FLUSH PRIVILEGES;"

RUN echo "ServerName 172.17.0.2" >> /etc/apache2/apache2.conf
RUN sed -i 's/bind-address\s*=\s*127\.0\.0\.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306
EXPOSE 5173
EXPOSE 8000

WORKDIR /var/www/html

CMD service mariadb start && apachectl -D FOREGROUND
