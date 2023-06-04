/* Public subnet */
resource "aws_subnet" "tf_public_subnet" {
  count                   = length(var.cidr_pub_sub)
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = element(var.cidr_pub_sub, count.index)
  availability_zone       = element(var.subnet_azs, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.client_name}-${var.env}-pub-subnet-${element(var.subnet_azs, count.index)}"
  }
}

/* Private subnet */
resource "aws_subnet" "tf_private_subnet" {
  count                   = length(var.cidr_priv_sub)
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = element(var.cidr_priv_sub, count.index)
  availability_zone       = element(var.subnet_azs, count.index)
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.client_name}-${var.env}-priv-subnet-${element(var.subnet_azs, count.index)}"
  }
}
