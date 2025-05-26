#!/bin/bash
sudo yum update -y
yum install -y httpd
systemctl enable httpd
systemctl start httpd
echo "<h1>Lab6 Terraform Deployment</h1>" > /var/www/html/index.html
