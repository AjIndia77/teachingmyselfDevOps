# ☄️Nginx Web Server Deployment on AWS EC2

## 1. Project Overview
Automated deployment of an Nginx web server on AWS EC2 using Bash scripting and Linux system administration skills.

## 2. Tech Stack
| Tool | Purpose |
|------|---------|
| AWS EC2 | Cloud server (ap-south-1 Mumbai, free tier) |
| Amazon Linux 2023 | Server operating system |
| Nginx | Web server |
| Bash | Automation scripting |
| SSH | Secure remote access |
| Git/GitHub | Version control |

## 3. Project Structure
```bash
nginx-aws-webserver/

├── setup.sh       # Automation script/
└── README.md      # Project documentation/
```

## 4. What This Project Does
1. Launches an AWS EC2 free-tier instance in Mumbai
2. Configures security groups (port 22 SSH, port 80 HTTP)
3. Connects via SSH using key-pair authentication
4. Installs and configures Nginx web server
5. Deploys a custom HTML webpage
6. Automates the entire setup with a Bash script

## 5. How to Run This Project Yourself

### Prerequisites
- AWS account (free tier)
- SSH key pair (.pem file)
- Amazon Linux 2023 EC2 instance running

### Steps
**1. Copy script to your server:**
```bash
scp -i your-key.pem setup.sh ec2-user@your-server-ip:~/
```

**2. SSH into your server:**
```bash
ssh -i your-key.pem ec2-user@your-server-ip
```

**3. Make script executable and run it:**
```bash
chmod +x setup.sh
./setup.sh
```

**4. Visit your server IP in a browser**

## 6. Key Concepts Demonstrated

**Linux Administration (RHCSA skills)**
- Package management with dnf
- Service management with systemctl
- File permissions with chmod
- SSH key-based authentication

**AWS Cloud**
- EC2 instance launch and configuration
- Security group setup (firewall rules)
- Key pair management
- Free tier usage

**Bash Scripting**
- Shebang line and script structure
- echo for progress output
- Comments for documentation
- Heredoc for multi-line file writing
- Automated service management

## 7. What I Learned
- How to provision and configure a cloud server from scratch
- How Linux services are managed with systemctl
- How to write reusable automation scripts
- How SSH key authentication works in practice
- How HTTP traffic flows from browser to web server

## Author
**Ambika Joshi**
B.Tech CSE | RHCSA V9 & V10 | EX188 Container Specialist

- LinkedIn: https://linkedin.com/in/ambika-joshi-aj
- GitHub: https://github.com/AjIndia77
