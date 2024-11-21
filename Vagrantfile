# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
  
  config.vm.box = "debian/bookworm64"

 
  config.vm.network "private_network", ip: "192.168.56.10"

  config.vm.provision "shell", inline: <<-SHELL
  # Add password to vagrant user
  echo "vagrant:vagrant" | chpasswd

  # Install Nginx if not installed
  sudo apt update
  sudo apt install -y nginx
  sudo systemctl start nginx

  # Configure website directory for my_site(from repo) and new_site(personal web)
  sudo mkdir -p /var/www/my_site/html
  sudo mkdir -p /var/www/new_site/html
   # Copy my site perfect_education_website into var/www/ and give permission
  sudo mkdir -p /var/www/perfect_education_website/html 

  #permision
  sudo chown -R www-data:www-data /var/www/my_site/html
  sudo chmod -R 755 /var/www/my_site

  sudo chown -R vagrant:www-data /var/www/new_site/html
  sudo chmod -R 755 /var/www/new_site

  sudo chown -R www-data:www-data /var/www/perfect_education_website/html
  sudo chmod -R 755 /var/www/perfect_education_website
   

  # install git to clone the repo
  sudo apt update
  sudo apt install git

  # my_site repo
  sudo git clone https://github.com/cloudacademy/static-website-example /var/www/my_site/html
  sudo cp -rv /vagrant/html/* /var/www/perfect_education_website/html
  

  # Config Nginx 
  sudo cp -v /vagrant/my_site/my_site /etc/nginx/sites-available/my_site
  sudo cp -v /vagrant/new_site/new_site /etc/nginx/sites-available/
  sudo cp -v /vagrant/perfect_education_website /etc/nginx/sites-available/perfect_education_website

  sudo ln -s /etc/nginx/sites-available/my_site /etc/nginx/sites-enabled/
  sudo ln -s /etc/nginx/sites-available/new_site /etc/nginx/sites-enabled/


  sudo ln -fs /etc/nginx/sites-available/perfect_education_website /etc/nginx/sites-enabled








# Config auth new web 



  # Restart Nginx
  sudo systemctl restart nginx

  # Install FTPS
  sudo apt update
  sudo apt install vsftpd -y


  # Create FTP directory
  sudo mkdir -p /home/vagrant/ftp
  sudo chmod -R 755 /home/vagrant/ftp
  sudo chown -R vagrant:vagrant /home/vagrant/ftp

 
  # Generate SSL certificates for vsftpd
  sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt -subj "/CN=my_site"

  # Copy vsftpd.conf file to /etc/
  sudo cp /vagrant/my_site/vsftpd.conf /etc/vsftpd.conf
  
  # Restart FTP
  sudo systemctl restart vsftpd
  

 
  # In order to test authentication with Nginx
  # Install openssl package and users and pass creation in /etc/nginx/.htpsswd
  sudo apt install apache2-utils
  sudo dpkg -l | grep openssl

  sudo htpasswd -c /etc/nginx/.htpasswd
  sudo sh -c "echo -n 'Paula:' >> /etc/nginx/.htpasswd"
  sudo sh -c "echo -n 'del_Moral:' >> /etc/nginx/.htpasswd"
  sudo sh -c "openssl passwd -apr1 'paulapsswd'>> /etc/nginx/.htpasswd"
  sudo sh -c "openssl passwd -apr1 'delMoralpsswd'>> /etc/nginx/.htpasswd"

  sudo systemctl restart nginx

SHELL
end
