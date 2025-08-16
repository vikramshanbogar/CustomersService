# Client VPN Endpoint
resource "aws_ec2_client_vpn_endpoint" "main" {
  description            = "${var.project_name} Client VPN"
  server_certificate_arn = aws_acm_certificate.server.arn
  client_cidr_block      = var.client_cidr_block
  
  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = aws_acm_certificate.client.arn
  }
  
  connection_log_options {
    enabled = false
  }
  
  tags = {
    Name = "${var.project_name}-client-vpn"
  }
}

# VPN Network Association
resource "aws_ec2_client_vpn_network_association" "main" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.main.id
  subnet_id              = var.public_subnet_id
}

# Authorization Rule
resource "aws_ec2_client_vpn_authorization_rule" "main" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.main.id
  target_network_cidr    = var.vpc_cidr_block
  authorize_all_groups   = true
}

# Route to VPC
resource "aws_ec2_client_vpn_route" "main" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.main.id
  destination_cidr_block = var.vpc_cidr_block
  target_vpc_subnet_id   = var.public_subnet_id
  
  depends_on = [aws_ec2_client_vpn_network_association.main]
}

# Server Certificate
resource "aws_acm_certificate" "server" {
  private_key      = tls_private_key.server.private_key_pem
  certificate_body = tls_self_signed_cert.server.cert_pem
  
  tags = {
    Name = "${var.project_name}-server-cert"
  }
}

# Client Certificate
resource "aws_acm_certificate" "client" {
  private_key      = tls_private_key.client.private_key_pem
  certificate_body = tls_self_signed_cert.client.cert_pem
  
  tags = {
    Name = "${var.project_name}-client-cert"
  }
}

# Server Private Key
resource "tls_private_key" "server" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Client Private Key
resource "tls_private_key" "client" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Server Certificate
resource "tls_self_signed_cert" "server" {
  private_key_pem = tls_private_key.server.private_key_pem
  
  subject {
    common_name = "${var.project_name}-server"
  }
  
  validity_period_hours = 8760 # 1 year
  
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

# Client Certificate # Creates self-signed certificates locally
resource "tls_self_signed_cert" "client" {
  private_key_pem = tls_private_key.client.private_key_pem
  
  subject {
    common_name = "${var.project_name}-client"
  }
  
  validity_period_hours = 8760 # 1 year
  
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "client_auth",
  ]
}