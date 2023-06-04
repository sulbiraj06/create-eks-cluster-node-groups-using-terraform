output "kms_key_arn" {
  value = aws_kms_key.ebs.arn
}
output "kms_key_id" {
  value = aws_kms_key.ebs.key_id
}
output "kms_key_alias_arn" {
  value = aws_kms_alias.ebs.target_key_arn
}

output "kms_alias_name" {
  description = "The display name of the alias."
  value       = aws_kms_alias.ebs.name
}