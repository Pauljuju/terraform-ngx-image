# aws key-pair #

resource "aws_key_pair" "sika-public-key" {
  key_name   = var.key_name
  public_key = tls_private_key.sika-private-key.public_key_openssh
}

resource "tls_private_key" "sika-private-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "sika-public-key" {
  content  = tls_private_key.sika-private-key.private_key_pem
  filename = "sikakey"
}