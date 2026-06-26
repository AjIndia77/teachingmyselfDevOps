#!/bin/bash

#===================================
# Nginx web server setup script
# Author: Ambika Joshi
# Desc: Automate Nginx installation
#       and deploy custom webpage on
#       AWS EC2
#===================================

echo "Starting Nginx Setup...."

# Update packages
echo "[1/4] updating system packages"
sudo dnf update -y

# Nginx installation
echo "[2/4] installing nginx service"
sudo dnf install nginx -y

# Staring and enabling nginx
echo "[3/4] starting & enabling nginx service"
sudo systemctl start nginx
sudo systemctl enable nginx

# Deplyment of custom webpage
echo "[4/4] executing custom webpage script"
sudo bash -c 'cat > /usr/share/nginx/html/index.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>Ambika Joshi | DevOps Project</title>
</head>
<body>
 <h1>Hello! I am Ambika Joshi</h1>
    <p>This web server is running on AWS EC2 (Mumbai) using Nginx on Amazon Linux.</p>
    <p>Automated setup using Bash shell scripting.</p>
    <ul>
        <li>OS: Amazon Linux 2023</li>
        <li>Web Server: Nginx</li>
        <li>Hosted on: AWS EC2 (ap-south-1)</li>
        <li>Automated with: Bash Script</li>
    </ul>
</body>
</html>
EOF'

# Verify Nginx is running
echo "Verifying Nginx status..."
sudo systemctl status nginx --no-pager

echo ""
echo "Setup complete! Your web server is running."
echo "Visit your server's public IP in a browser to confirm."