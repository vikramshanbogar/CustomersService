#!/bin/bash

# Get VPN endpoint ID
VPN_ENDPOINT_ID=$(terraform output -raw vpn_endpoint_id)

# Download client configuration
aws ec2 export-client-vpn-client-configuration --client-vpn-endpoint-id $VPN_ENDPOINT_ID --output text > client-config.ovpn

# Get certificates
terraform output -raw vpn_client_certificate > client.crt
terraform output -raw vpn_client_private_key > client.key

# Append certificates to config
echo "" >> client-config.ovpn
echo "<cert>" >> client-config.ovpn
cat client.crt >> client-config.ovpn
echo "</cert>" >> client-config.ovpn
echo "" >> client-config.ovpn
echo "<key>" >> client-config.ovpn
cat client.key >> client-config.ovpn
echo "</key>" >> client-config.ovpn

echo "VPN configuration generated: client-config.ovpn"
echo "Install OpenVPN client on Ubuntu: sudo apt install openvpn"
echo "Connect using: sudo openvpn client-config.ovpn"