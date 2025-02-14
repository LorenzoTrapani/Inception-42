FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y && apt install -y nginx

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]