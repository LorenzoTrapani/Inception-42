FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y && apt install -y nginx

COPY default /etc/nginx/sites-available/.

CMD ["nginx", "-g", "daemon off;"]