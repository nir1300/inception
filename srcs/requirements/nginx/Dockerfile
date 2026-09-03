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
COPY tools/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

#launch nginx binary
#force nginx to run in foreground to keep PID1 active -> container stays running
CMD ["nginx", "-g", "daemon off;"]

#resources:
#https://docs.openssl.org/master/man1/openssl-req/
#https://nginx.org/en/docs/http/configuring_https_servers.html
#https://smithtalkstech.com/2018/04/25/creating-a-self-signed-ssl-certificate-for-local-docker-development/
#https://codingwithmanny.medium.com/configure-self-signed-ssl-for-nginx-docker-from-a-scratch-7c2bcd5478c6