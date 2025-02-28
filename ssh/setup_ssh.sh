#!/usr/bin/env bash

# Generate an SSH key pair (if it doesn't already exist)
if [ ! -f ~/.ssh/school ]; then
    echo "Generating SSH key pair..."
    ssh-keygen -b 4096 -f ~/.ssh/school -N "betty"
    echo "SSH key pair generated: ~/.ssh/school and ~/.ssh/school.pub"
else
    echo "SSH key pair already exists at ~/.ssh/school"
fi

# Add the public key to the server's authorized_keys file
echo "Copying public key to the server..."
ssh-copy-id -i ~/.ssh/school.pub ubuntu@192.168.1.70

# Configure SSH to use the private key and disable password authentication
echo "Configuring SSH client..."
cat <<EOL >> ~/.ssh/config
Host 192.168.1.70
    HostName 192.168.1.70
    User ubuntu
    IdentityFile ~/.ssh/school
    PasswordAuthentication no
EOL

echo "SSH configuration updated. You can now connect using: ssh ubuntu@192.168.1.70"

# Test the connection
echo "Testing connection to the server..."
ssh -i ~/.ssh/school ubuntu@44.192.38.3 "echo 'Connection successful!'"
