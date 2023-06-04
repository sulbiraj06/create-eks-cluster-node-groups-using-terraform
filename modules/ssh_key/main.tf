resource "tls_private_key" "key" {
  algorithm = "RSA"
}

#To save the pemfile in local machine
resource "local_sensitive_file" "private_key" {
  filename        = "${lower(var.client_name)}-${var.env}.pem"
  content         = tls_private_key.key.private_key_pem
  file_permission = "0400"
}

#Create keypair
resource "aws_key_pair" "key_pair" {
  key_name   = "${lower(var.client_name)}-${var.env}"
  public_key = tls_private_key.key.public_key_openssh
  tags = {
    Name = "${lower(var.client_name)}-${var.env}"
    "insurity:resource:type" = "key-pair"
    "insurity:application:role" = "utility"
  }
}

#Upload pemfile to S3 bucket
# resource "aws_s3_object" "object" {
#   bucket    = var.pem_s3_bucket
#   key       = "pemfiles/prod/${lower(var.client_name)}-${var.env}.pem"
#   acl       = "private"  # or can be "public-read"
#   source    = "./${lower(var.client_name)}-${var.env}.pem"
#   etag      = filemd5("./${lower(var.client_name)}-${var.env}.pem")
# }