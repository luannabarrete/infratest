server {
    listen 8080 default_server;

    root /usr/share/nginx/dox;
    index index.php index.html index.htm amdocs.html;

    server_name infratest.com www.infratest.com;
    location / {
        try_files $uri $uri/ /index.php;
    }

    location ~ \.php$ {
        fastcgi_pass unix:/run/php/php7.2-fpm.sock;
        include snippets/fastcgi-php.conf;
    }
}
