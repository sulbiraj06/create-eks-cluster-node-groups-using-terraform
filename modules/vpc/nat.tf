#Create Elastic IP
/* Elastic IP for NAT */
resource "aws_eip" "tf_nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.tf_igw]
  tags = {
    Name = "${var.client_name}-EIP-${var.env}-nat"
  }
}

#Create NAT Gateway
/* NAT */
resource "aws_nat_gateway" "tf_nat" {
  allocation_id = aws_eip.tf_nat_eip.id
  subnet_id     = element(aws_subnet.tf_public_subnet.*.id, 0)
  depends_on    = [aws_internet_gateway.tf_igw]
  tags = {
    Name = "${var.client_name}-${var.env}-NATgw"
  }
}
