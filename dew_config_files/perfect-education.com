server {
	listen 80;
	listen [::]:80;
	root /var/www/perfect_education_website/html;
	index index.html index.htm index.nginx-debian.html;
	server_name perfect-education.com www.perfect-education.com;
	location / {
		try_files $uri $uri/ =404;
 }
}
