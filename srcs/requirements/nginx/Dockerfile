FROM debian:bookworm

#install nginx and get default directory structure /etc/nginx
#install openssl so i can generate self/signed ssl/tls certificate for https
RUN apt-get update && apt-get install -y nginx openssl && rm -rf /var/lib/apt/lists/* 
# clear package caches to keep container image size small

#create directory for ssl certificate and key
RUN mkdir -p /etc/nginx/ssl

#generate self-signed certificate
RUN openssl req -x509 -nodes -days 365 \
    -subj "/C=AT/ST=Vienna/O=42/CN=nrumpfhu.42.fr" \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt;
#copy custom config file and override default
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

#launch nginx binary
#force nginx to run in foreground to keep PID1 active -> container stays running
CMD ["nginx", "-g", "daemon off;"]
