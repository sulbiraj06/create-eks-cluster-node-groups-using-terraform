/*create public route table*/
resource "aws_route_table" "tf_public_route_table" {
  vpc_id = aws_vpc.tf_vpc.id
  tags = {
    Name = "${var.client_name}-${var.env}-public-route-table"
  }
}
/* Edit the route and attach IGW */
resource "aws_route" "tf_public_internet_gateway" {
  route_table_id         = aws_route_table.tf_public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.tf_igw.id
}
/* associate with public subnet */
resource "aws_route_table_association" "tf_public_rt_association" {
  count          = length(var.cidr_pub_sub)
  subnet_id      = element(aws_subnet.tf_public_subnet.*.id, count.index)
  route_table_id = aws_route_table.tf_public_route_table.id
}

# /* ================================================================================== */

/* Create a private route table */
resource "aws_route_table" "tf_private_route_table" {
  vpc_id = aws_vpc.tf_vpc.id
  tags = {
    Name = "${var.client_name}-${var.env}-private-route-table"
  }
}
/* Edit the route and attach NAT gateway */
resource "aws_route" "tf_private_nat_gateway" {
  route_table_id         = aws_route_table.tf_private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.tf_nat.id
}
/* associate with private subnet */
resource "aws_route_table_association" "tf_private_rt_association" {
  count          = length(var.cidr_priv_sub)
  subnet_id      = element(aws_subnet.tf_private_subnet.*.id, count.index)
  route_table_id = aws_route_table.tf_private_route_table.id
}
