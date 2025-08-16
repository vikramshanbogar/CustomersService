output "client_vpn_endpoint_id" {
  description = "Client VPN endpoint ID"
  value       = aws_ec2_client_vpn_endpoint.main.id
}

output "client_certificate" {
  description = "Client certificate for VPN connection"
  value       = tls_locally_signed_cert.client.cert_pem
  sensitive   = true
}

output "client_private_key" {
  description = "Client private key for VPN connection"
  value       = tls_private_key.client.private_key_pem
  sensitive   = true
}

output "ca_certificate" {
  description = "CA certificate for VPN connection"
  value       = tls_self_signed_cert.ca.cert_pem
  sensitive   = true
}