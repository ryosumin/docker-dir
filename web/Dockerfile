FROM nginx:1.7.8
#MAINTAINER Jason Wilder jwilder@litl.com

# Install wget and install/updates certificates
RUN apt-get update \
 && apt-get install -y -q --no-install-recommends \
 ca-certificates \
 wget \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

COPY conf/nginx.conf /etc/nginx/nginx.conf
# Configure Nginx and apply fix for long server names
RUN echo "daemon off;" >> /etc/nginx/nginx.conf \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log


RUN wget https://github.com/jwilder/dockerize/releases/download/v0.0.1/dockerize-linux-amd64-v0.0.1.tar.gz \
    && tar -C /usr/local/bin -xvzf dockerize-linux-amd64-v0.0.1.tar.gz
#RUN curl -L https://github.com/jwilder/dockerize/releases/download/v0.0.1/dockerize-linux-amd64-v0.0.1.tar.gz | tar xz -C /usr/local/bin

#ADD default.tmpl /etc/nginx/conf.d/default.tmpl

VOLUME ["/var/cache/nginx"]

EXPOSE 80 443

CMD dockerize -template /etc/nginx/conf.d/default.tmpl:/etc/nginx/conf.d/default.conf -stdout /var/log/nginx/access.log -stderr /var/log/nginx/error.log nginx
