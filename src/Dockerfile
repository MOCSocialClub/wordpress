FROM wordpress:php8.3

# Install NGINX, openssh-server, and supervisor
RUN apt-get update && \
    apt-get install -y nginx openssh-server supervisor && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configure NGINX
COPY nginx_conf/nginx.conf /etc/nginx/nginx.conf
COPY nginx_conf/default.conf /etc/nginx/conf.d/default.conf
COPY nginx_conf/spec-settings.conf /etc/nginx/conf.d/spec-settings.conf

# Configure SSH
RUN mkdir /var/run/sshd && echo 'root:Docker!' | chpasswd

COPY sshd_config /etc/ssh/

# Configure Supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose ports
EXPOSE 80 443 2222

# Launch Supervisor
CMD ["/usr/bin/supervisord"]