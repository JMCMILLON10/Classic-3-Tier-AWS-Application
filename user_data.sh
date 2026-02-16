#!/bin/bash

# Update system (Amazon Linux)
yum update -y
yum install -y httpd

# Start & enable Apache
systemctl start httpd
systemctl enable httpd

# Create health endpoint (CRITICAL for ALB)
mkdir -p /var/www/html
echo ok > /var/www/html/health
chmod 644 /var/www/html/health

# Basic homepage
echo "
<!doctype html>
<html>
<head>
  <title>Classic 3-Tier App</title>
</head>
<body>
  <h1>Classic 3-Tier Application</h1>
  <p>Apache is running ✔</p>
</body>
</html>
" > /var/www/html/index.html