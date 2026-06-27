#!/bin/bash

sudo apt-get update
sudo apt-get install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

echo "<h1> Terraform-TWS-Project Shell Scrpting Automation" | sudo tee /var/www/html/index.html