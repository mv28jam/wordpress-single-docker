# Wordpress single Docker. 

Wordpress single Docker. Creates docker with Wordpress site and automatically install ssl certificate with Certbot. Migrate Wordpress site to docker, restore content from dumps and automatically install ssl certificate with Certbot.  

#### Contains:
- Wordpress latest (or ver from dump)
- nginx
- php8.1
- php8.1-fpm
- MariaDB 
- Certbot
- ubuntu:jammy version

## Create new Wordpress site.
1. Install Docker
2. Clone code
3. Set environment to "dif env" of Dockerfile-new to create site with your credentials
4. Run code  
<code>$chmod 775 ./sh/build_new.sh</code>  
<code>$sudo ./sh/build_new.sh</code>
5. Go to your site domain to process Wordpress installation

## Migrate or restore existing Wordpress site.
1. Install Docker
2. Clone code
3. Dump your database in dump.slq file  
   <code>mysqldump <your_database> > dump.sql</code>  
    If you use not standard WP table prefix 'wp_', replace it with default.   
    For example  
   <code>sed -i "s/\`<custom_prefix>\_/\`wp\_/g" dump.sql</code>
4. Dump your site dir  
   <code>zip -r wordpress.zip <your_wordpress_dir> </code>
5. Copy wordpress.zip and dump.sql to ./data/
6. Set environment to "dif env" of Dockerfile-existing to create site with your credentials. Database credentials can differ from original - it's OK.
7. Run code  
   <code>$chmod 775 ./sh/build_new.sh</code>  
<code>$sudo ./sh/build_new.sh</code>
8. Go to your site domain and check workability

Do NOT support migration from php7.* - Wordpress will not start. Run Docker for new WP, and use one of internal WP migration tools in new docker WP site administration panel. 

## ENV description
1. Database password for Wordpress user  
   <code>ENV MARIADB_PASS=password</code>
2. Domains to listen by nginx.Add developer domain in list to test locally.  
   <code>ENV DOMAINS='example.com www.example.com example.dev'</code>
3. Certbot mail to get certificate and manage it.  
   <code>ENV CERTBOT_MAIL=user@example.com </code>
4. Domain to get ssl certificate by Certbot. Domain WITHOUT(!) www. / www.example.com will add automatically  
   <code>ENV CERTBOT_DOMAIN=example.com</code>
5. Time zone for system  
   <code>ENV TZ=UTC</code>
6. Nginx and php.ini post/file memory limit  
   <code>ENV PHP_LIMIT=128M</code>
7. Database name.  
   <code>ENV MARIADB_DB=wordpress_db</code>
8. Database user.  
   <code>ENV MARIADB_USER=wordpress</code>
9. Wordpress hash.  
   <code>ENV WP_HASH='hash'</code>

## DEV
### dev domains
When run with dev unreachable domains Certbot will silent fall with error. 443 will not work. Nginx conf will not change.

### run with without sh
docker build -f Dockerfile-existing . -t wp-cont  
docker run --memory=256m --cpus=".5" -p 80:80 -p 443:443 -d -it wp-cont 
