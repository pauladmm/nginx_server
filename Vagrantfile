# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
  
  config.vm.box = "debian/bookworm64"

 
  config.vm.network "private_network", ip: "192.168.56.10"

  config.vm.provision "shell", inline: <<-SHELL
  # Add password to vagrant user
  echo "vagrant:vagrant" | chpasswd

  # Install Nginx if not installed
    apt update
    apt install -y nginx
    apt install git
    apt install vsftpd -y
    apt install apache2-utils
  apt-get install -y bind9
  apt install ufw
  

  # Configure website directory for my_site(from repo) & new_site(personal web) & perfect_education_website(auth)
    mkdir -p /var/www/my_site/html
    mkdir -p /var/www/new_site/html
    mkdir -p /var/www/perfect_education_website/html 

  # permisions
    chown -R www-data:www-data /var/www/my_site/html
    chmod -R 755 /var/www/my_site

    chown -R vagrant:www-data /var/www/new_site/html
    chmod -R 755 /var/www/new_site

    chown -R www-data:www-data /var/www/perfect_education_website/html
    chmod -R 755 /var/www/perfect_education_website
   


  # my_site repo & perfect_education_website
    git clone https://github.com/cloudacademy/static-website-example /var/www/my_site/html
    cp -rv /vagrant/html/* /var/www/perfect_education_website/html
  

  # Config Nginx 
    cp -v /vagrant/my_site/my_site /etc/nginx/sites-available/my_site
    cp -v /vagrant/new_site/new_site /etc/nginx/sites-available/
  # This last version allow host to access with credentials and ip
    cp -v /vagrant/perfect_education_website /etc/nginx/sites-available/perfect_education_website

  # copy config files from DNS server perfect-education.com
  cp /vagrant/dew_config_files/db.perfect-education.com /etc/bind/db.perfect-education.com
  cp /vagrant/dew_config_files/named.conf.local /etc/bind/named.conf.local

  # config server_block for perfect-education.com
  cp /vagrant/dew_config_files/perfect-education.com /etc/nginx/sites-available/perfect-education.com 

  systemctl restart bind9
  systemctl reload nginx

    ln -s /etc/nginx/sites-available/my_site /etc/nginx/sites-enabled/
    ln -s /etc/nginx/sites-available/new_site /etc/nginx/sites-enabled/


    ln -fs /etc/nginx/sites-available/perfect_education_website /etc/nginx/sites-enabled
    ln -fs /etc/nginx/sites-available/perfect-education.com /etc/nginx/sites-enabled

  # Restart Nginx
    systemctl restart nginx

 

  # Create FTP directory
    mkdir -p /home/vagrant/ftp
    chmod -R 755 /home/vagrant/ftp
    chown -R vagrant:vagrant /home/vagrant/ftp

 
  # Generate SSL certificates for vsftpd
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt -subj "/CN=my_site"

  # Copy vsftpd.conf file to /etc/
    cp /vagrant/my_site/vsftpd.conf /etc/vsftpd.conf
  
 

 
  # In order to test authentication with Nginx
  # Install openssl package and users and pass creation in /etc/nginx/.htpsswd
  
    dpkg -l | grep openssl

    htpasswd -c /etc/nginx/.htpasswd

  # User and password creation
    sh -c "echo -n 'Paula:' >> /etc/nginx/.htpasswd"
    sh -c "echo -n 'del_Moral:' >> /etc/nginx/.htpasswd"
    sh -c "openssl passwd -apr1 'paulapsswd'>> /etc/nginx/.htpasswd"
    sh -c "openssl passwd -apr1 'delMoralpsswd'>> /etc/nginx/.htpasswd"

    systemctl restart nginx

  # Firewall enabled
   ufw allow ssh 
   ufw allow 'Nginx Full'
   ufw delete allow 'Nginx HTTP' 

   # Certification generation
   openssl req -x509 -nodes -days 365 \
   -newkey rsa:2048 \
   -keyout /etc/ssl/private/perfect-education.com.key \
   -out /etc/ssl/certs/perfect-education.com.crt

   systemctl reload nginx

SHELL
end
