#Create VPC
resource "aws_vpc" "tf_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.tenancy
  enable_dns_hostnames = true

  tags = {
    Name = "${var.client_name}-${var.env}-VPC"
  }
}
