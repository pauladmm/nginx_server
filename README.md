# Nginx Web Server and FTPS Configuration on Debian with Vagrant

## Overview

This repository provides instructions and configurations for setting up an Nginx web server on a Debian virtual machine managed with Vagrant. It includes steps to configure a second domain, transfer files securely using FTPS, and perform essential server management tasks like log verification and permission adjustments.

## Requirements

- [Vagrant](https://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/) (or another Vagrant-compatible provider)
- [Git](https://git-scm.com/) for repository management

## Setup Instructions

### 1. Clone the Repository

Clone this repository to your local machine:

```bash
git clone <URL-of-this-repository>
cd <repository-name>
```

### 2. Configure the Vagrantfile

The Vagrantfile in this repository is pre-configured to install and start Nginx automatically on a Debian virtual machine.

To adjust the network settings or other parameters:

Open Vagrantfile.
Set the desired IP address or network configuration.
Example configuration with a fixed IP:

`config.vm.network "private_network", ip: "192.168.56.10"`

### 3. Create and Configure Your Web Directory

A directory for the website content was created:

`sudo mkdir -p /var/www/my_site/html`
A example website repository was cloned in this directory:

`git clone https://github.com/cloudacademy/static-website-example /var/www/my_site/html`
Appropriate permissions was set:

`sudo chown -R www-data:www-data /var/www/my_site/html`
`sudo chmod -R 755 /var/www/my_site`

To test that server is working correctly, in this case client should be accesed by:
http://192.158.56.10

### 4. Configure the Nginx Server Block

A new server block for the website is created:

`sudo nano /etc/nginx/sites-available/my_site`
With the following configuration:

```bash
server {
    listen 80;
    server_name my_site;
    root /var/www/my_site/html;
    index index.html index.htm;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

With a symbolic link to enable the site:

````bash
sudo ln -s /etc/nginx/sites-available/my_site/etc/nginx/sites-enabled/
sudo systemctl restart nginx```
````
