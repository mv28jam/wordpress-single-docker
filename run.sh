#!/bin/bash
service php8.1-fpm start
service nginx -s reload
service nginx start
mysqld_safe