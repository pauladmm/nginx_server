
# Nginx Web Server and FTPS Configuration on Debian with Vagrant

## 📖 Overview

This repository provides a comprehensive guide for setting up a Debian-based Nginx web server and FTPS service within a Vagrant-managed virtual machine. The project includes:

- Setting up two websites (`my_site` and `new_site`) with Nginx.
- Secure file transfer using FTPS.
- Proper directory structure and permission configuration.
- Debugging logs and troubleshooting common issues.

## 📋 Requirements

Ensure the following tools are installed on your local machine:

- [Vagrant](https://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/) (or another Vagrant-compatible provider)
- [Git](https://git-scm.com/) for cloning repositories

## ⚙️ Setup Instructions

### 1️⃣ Clone the Repository

Start by cloning this repository to your local machine:

```bash
git clone <repository-url>
cd <repository-name>
```

### 2️⃣ Configure the Vagrantfile

The included `Vagrantfile` is pre-configured to:

- Install and start Nginx.
- Create necessary directories for the websites.
- Set up FTPS.

You can adjust network settings if needed. For instance, to configure a private network with a fixed IP, ensure the following is present in the `Vagrantfile`:

```ruby
config.vm.network "private_network", ip: "192.168.56.10"
```

### 3️⃣ Configure the `my_site` Web Directory

1. **Create the web directory:**
   ```bash
   sudo mkdir -p /var/www/my_site/html
   ```

2. **Clone an example website:**
   ```bash
   git clone https://github.com/cloudacademy/static-website-example /var/www/my_site/html
   ```

3. **Set permissions:**
   ```bash
   sudo chown -R www-data:www-data /var/www/my_site/html
   sudo chmod -R 755 /var/www/my_site
   ```

### 4️⃣ Set Up Nginx for `my_site`

Create a server block configuration for `my_site`:

```bash
sudo nano /etc/nginx/sites-available/my_site
```

Add the following content:

```nginx
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

Enable the site and restart Nginx:

```bash
sudo ln -s /etc/nginx/sites-available/my_site /etc/nginx/sites-enabled/
sudo systemctl restart nginx
```

### 5️⃣ Test Access to `my_site`

1. Add the domain mapping to your host's file (on Windows):
   ```plaintext
   192.168.56.10 my_site
   ```

2. Open a browser and visit: `http://my_site`.

3. Check logs for issues:
   - Access log: `/var/log/nginx/access.log`
   - Error log: `/var/log/nginx/error.log`

---

## 🌐 Setting Up `new_site`

1. **Create the web directory:**
   ```bash
   sudo mkdir -p /var/www/new_site/html
   ```

2. **Set permissions:**
   ```bash
   sudo chown -R vagrant:www-data /var/www/new_site/html
   sudo chmod -R 755 /var/www/new_site
   ```

3. **Set up Nginx configuration for `new_site`:**
   ```bash
   sudo nano /etc/nginx/sites-available/new_site
   ```

   Add the following content:

   ```nginx
   server {
       listen 80;
       listen [::]:80;
       root /home/vagrant/ftp;
       index index.html index.htm;
       server_name new_site;

       location / {
           try_files $uri $uri/ =404;
       }
   }
   ```

4. **Enable the site and restart Nginx:**
   ```bash
   sudo ln -s /etc/nginx/sites-available/new_site /etc/nginx/sites-enabled/
   sudo systemctl restart nginx
   ```

5. **Test Access to `new_site`:**
   Add the domain mapping to your host's file (on Windows):
   ```plaintext
   192.168.56.10 new_site
   ```
   Open a browser and visit: `http://new_site`.

## 🔒 Setting Up FTPS

1. **Install vsftpd:**
   ```bash
   sudo apt-get update
   sudo apt-get install vsftpd
   ```

2. **Create an FTP directory:**
   ```bash
   sudo mkdir -p /home/vagrant/ftp
   sudo chmod -R 755 /home/vagrant/ftp
   sudo chown -R vagrant:vagrant /home/vagrant/ftp
   ```

3. **Generate SSL Certificates:**
   ```bash
   sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
   -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt
   ```

4. **Restart vsftpd:**
   ```bash
   sudo systemctl restart vsftpd
   ```
