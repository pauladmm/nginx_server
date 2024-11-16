# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
  
  config.vm.box = "debian/bookworm64"

 
  config.vm.network "private_network", ip: "192.168.56.10"

  config.vm.provision "shell", inline: <<-SHELL
  # Install Nginx if not installed
  sudo apt update
  sudo apt install -y nginx
  sudo systemctl start nginx

  # Configure website directory
  sudo mkdir -p /var/www/my_site/html
  sudo git clone https://github.com/cloudacademy/static-website-example /var/www/my_site/html
  sudo chown -R vagrant:vagrant /var/www/my_site/html
  sudo chmod -R 755 /var/www/my_site

  # Copy config file to Nginx directory
  sudo cp /vagrant/my_site/my_site /etc/nginx/sites-available/my_site

  # Create symbolic link to enable the site
  sudo ln -s /etc/nginx/sites-available/my_site /etc/nginx/sites-enabled/my_site

  # Restart Nginx
  sudo systemctl restart nginx

  # Install FTPS
  sudo apt-get update
  sudo apt-get install vsftpd

  # Create FTP directory
  sudo mkdir -p /home/vagrant/ftp
 
  # Generate SSL certificates for vsftpd
  sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt -subj "/CN=my_site"

  # Copy vsftpd.conf file to /etc/
  sudo cp /vagrant/my_site/vsftpd.conf /etc/vsftpd.conf
  
  # Restart FTP
  sudo systemctl restart vsftpd

  
 
SHELL
end
