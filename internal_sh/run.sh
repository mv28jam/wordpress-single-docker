#!/bin/bash
service php8.1-fpm start

service nginx -s reload
service nginx start

certbot --nginx --https-port 443 --agree-tos -m CERTBOT_MAIL -d CERTBOT_DOMAIN -d www.CERTBOT_DOMAIN --non-interactive

service nginx -s reload
service nginx start

mysqld_safe