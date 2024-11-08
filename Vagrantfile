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

  # Copy config file to Nginx directory
  sudo cp /vagrant/my_site/my_site /etc/nginx/sites-available/my_site

  # Create symbolic link to enable the site
  sudo ln -s /etc/nginx/sites-available/my_site /etc/nginx/sites-enabled/my_site

  # Restart Nginx
  sudo systemctl restart nginx

  # Install FTPS
  sudo apt-get update
  sudo apt-get install vsftpd

SHELL
end
