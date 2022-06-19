FROM nginx
MAINTAINER JAREER
WORKDIR /usr/share/nginx/html
ADD index.html .
EXPOSE 80