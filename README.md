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
