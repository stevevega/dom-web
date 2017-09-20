FROM nginx:1.13.5-alpine
COPY . /usr/share/nginx/html
COPY vhost /etc/nginx/conf.d
EXPOSE 8080