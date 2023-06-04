output "id_of_db_instance" {
  value = aws_instance.db-server-instance-1.*.id
}