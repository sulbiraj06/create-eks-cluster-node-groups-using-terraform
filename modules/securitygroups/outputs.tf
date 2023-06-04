# output "id_of_vpc" {
#     value = aws_vpc.tf_vpc.id
# }

# output "alb_hostname" {
#   value = aws_alb.alb.dns_name
# }

output "id_of_g2_sg" {
  value = aws_security_group.G2-sg.id
}
output "id_of_etm_sg" {
  value = aws_security_group.etm-sg.id
}
output "id_of_db_sg" {
  value = aws_security_group.db-sg.id
}
output "id_of_etm_alb_sg" {
  value = aws_security_group.etm-alb-sg.id
}
output "id_of_etm_int_alb_sg" {
  value = aws_security_group.etm-int-alb-sg.id
}
output "id_of_g2_alb_sg" {
  value = aws_security_group.g2-alb-sg.id
}
output "id_of_sst_lm_sg" {
  value = aws_security_group.SST-LM-sg.id
}