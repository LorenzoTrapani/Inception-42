FROM debian:bullseye

# update and upgrade package manager
# install nginx && openssl
RUN apt-get update -y && apt-get upgrade -y && apt install -y nginx OpenSSL

# store nginx certificate & data
RUN mkdir -p /var/run/nginx

# setting up security
RUN openssl req-x509

# placing nginx conf
COPY conf/nginx.conf /etc/nginx/nginx.conf

# setting the rules (This ensures the right "people" (processes) can access and modify the web content.)
RUN chmod 755 /var/www/html && chown -R www-data:www-data /var/www/html

# start
CMD ["nginx", "-g", "daemon off;"]