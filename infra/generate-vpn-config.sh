#!/bin/bash

# Get VPN endpoint ID
VPN_ENDPOINT_ID=$(terraform output -raw vpn_endpoint_id)

# Download client configuration
aws ec2 export-client-vpn-client-configuration --client-vpn-endpoint-id $VPN_ENDPOINT_ID --output text > client-config.ovpn

# Get certificates
terraform output -raw vpn_client_certificate > client.crt
terraform output -raw vpn_client_private_key > client.key
terraform output -raw vpn_ca_certificate > ca.crt

# Append certificates to config
echo "" >> client-config.ovpn
echo "<cert>" >> client-config.ovpn
cat client.crt >> client-config.ovpn
echo "</cert>" >> client-config.ovpn
echo "" >> client-config.ovpn
echo "<key>" >> client-config.ovpn
cat client.key >> client-config.ovpn
echo "</key>" >> client-config.ovpn
echo "" >> client-config.ovpn
echo "<ca>" >> client-config.ovpn
cat ca.crt >> client-config.ovpn
echo "</ca>" >> client-config.ovpn

# Add Ubuntu split tunnel configuration
echo "" >> client-config.ovpn
echo "# Ubuntu split tunnel configuration" >> client-config.ovpn
echo "route-nopull" >> client-config.ovpn
echo "route 10.0.0.0 255.255.0.0" >> client-config.ovpn
echo "dhcp-option DNS 8.8.8.8" >> client-config.ovpn
echo "dhcp-option DNS 8.8.4.4" >> client-config.ovpn

echo "VPN configuration generated: client-config.ovpn"
echo "For Ubuntu: sudo apt install openvpn && sudo openvpn client-config.ovpn"
echo "This config uses split tunneling - only VPC traffic goes through VPN"