server {
	listen 80;
	listen 443 ssl;
	root /var/www/perfect_education_website/html;
	index index.html index.htm index.nginx-debian.html;
	server_name perfect-education.com www.perfect-education.com;
	ssl_certificate /etc/ssl/certs/perfect-education.com.crt;
 	ssl_certificate_key /etc/ssl/private/perfect-education.com.key;
 	ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3; 
 	ssl_ciphers HIGH:!aNULL:!MD5;

	location / {
		try_files $uri $uri/ =404;
 }
}
