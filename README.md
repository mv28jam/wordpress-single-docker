# wordpress-single-docker
Wordpress single Docker php8.1+fpm+nginx+MariaDB, create new or migrate old.  

sudo docker build -f Dockerfile-existing . -t wp-cont  
sudo docker run -p 80:80 -p 443:443 -d -it wp-cont
