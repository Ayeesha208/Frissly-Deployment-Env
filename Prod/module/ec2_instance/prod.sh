#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt-get update -y



# Install Java
sudo apt-get update
sudo apt-get install fontconfig openjdk-17-jre -y


# Install Docker
# Add Docker's official GPG key
sudo apt-get update -y
sudo apt-get install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo chmod 666 /var/run/docker.sock
sudo usermod -aG docker jenkins
sudo usermod -aG docker ubuntu
sudo systemctl enable docker
sudo systemctl start docker
echo "Docker installation complete."



# Install SonarQube
# Install unzip if not already installed
sudo apt-get install unzip -y

# Create a user for SonarQube
sudo adduser --disabled-password --gecos 'SonarQube' sonarqube

# Switch to SonarQube user and install SonarQube
sudo su - sonarqube <<EOF
# Fetch the latest SonarQube version from the official source
SONARQUBE_VERSION=$(curl -s https://api.github.com/repos/SonarSource/sonarqube/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
SONARQUBE_URL="https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-${SONARQUBE_VERSION}.zip"

# Download and extract SonarQube
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.4.0.54424.zip
unzip sonarqube-9.4.0.54424.zip
chmod -R 755 /home/sonarqube/sonarqube-9.4.0.54424
# Change ownership
chown -R sonarqube:sonarqube /home/sonarqube/sonarqube-9.4.0.54424
# Start SonarQube
cd sonarqube-9.4.0.54424/bin/linux-x86-64/
./sonar.sh start
EOF

echo "Installation complete. Jenkins, Docker, Maven, Git, and SonarQube are set up."
echo "Sonarqube installation complete."