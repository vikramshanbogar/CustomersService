# Client VPN Endpoint
resource "aws_ec2_client_vpn_endpoint" "main" {
  description            = "${var.project_name} Client VPN"
  server_certificate_arn = aws_acm_certificate.server.arn
  client_cidr_block      = var.client_cidr_block
  
  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = aws_acm_certificate.ca.arn
  }
  
  connection_log_options {
    enabled = false
  }
  
  tags = {
    Name = "${var.project_name}-client-vpn"
  }
}

# VPN Network Association (must be public for connectivity)
resource "aws_ec2_client_vpn_network_association" "main" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.main.id
  subnet_id              = var.public_subnet_id
}

# Authorization Rule for VPC
resource "aws_ec2_client_vpn_authorization_rule" "vpc" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.main.id
  target_network_cidr    = var.vpc_cidr_block
  authorize_all_groups   = true
}





# Server Certificate
resource "aws_acm_certificate" "server" {
  private_key       = tls_private_key.server.private_key_pem
  certificate_body  = tls_locally_signed_cert.server.cert_pem
  certificate_chain = tls_self_signed_cert.ca.cert_pem
  
  tags = {
    Name = "${var.project_name}-server-cert"
  }
}

# CA Certificate
resource "aws_acm_certificate" "ca" {
  private_key      = tls_private_key.ca.private_key_pem
  certificate_body = tls_self_signed_cert.ca.cert_pem
  
  tags = {
    Name = "${var.project_name}-ca-cert"
  }
}

# Client Certificate
resource "aws_acm_certificate" "client" {
  private_key      = tls_private_key.client.private_key_pem
  certificate_body = tls_locally_signed_cert.client.cert_pem
  certificate_chain = tls_self_signed_cert.ca.cert_pem
  
  tags = {
    Name = "${var.project_name}-client-cert"
  }
}

# Server Private Key
resource "tls_private_key" "server" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# CA Private Key
resource "tls_private_key" "ca" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Client Private Key
resource "tls_private_key" "client" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# CA Certificate
resource "tls_self_signed_cert" "ca" {
  private_key_pem = tls_private_key.ca.private_key_pem
  
  subject {
    common_name  = "${var.project_name}-ca"
    organization = "${var.project_name}"
  }
  
  validity_period_hours = 8760
  is_ca_certificate     = true
  
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "cert_signing",
  ]
}

# Server Certificate
resource "tls_locally_signed_cert" "server" {
  cert_request_pem   = tls_cert_request.server.cert_request_pem
  ca_private_key_pem = tls_private_key.ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca.cert_pem
  
  validity_period_hours = 8760
  
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "tls_cert_request" "server" {
  private_key_pem = tls_private_key.server.private_key_pem
  
  subject {
    common_name  = "${var.project_name}-server.local"
    organization = "${var.project_name}"
  }
  
  dns_names = ["${var.project_name}-server.local"]
}

# Client Certificate
resource "tls_locally_signed_cert" "client" {
  cert_request_pem   = tls_cert_request.client.cert_request_pem
  ca_private_key_pem = tls_private_key.ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca.cert_pem
  
  validity_period_hours = 8760
  
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "client_auth",
  ]
}

resource "tls_cert_request" "client" {
  private_key_pem = tls_private_key.client.private_key_pem
  
  subject {
    common_name  = "${var.project_name}-client.local"
    organization = "${var.project_name}"
  }
  
  dns_names = ["${var.project_name}-client.local"]
}