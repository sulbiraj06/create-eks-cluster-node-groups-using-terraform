resource "aws_kms_key" "ebs" {
  description             = "${var.client_name}-${var.env}-CMK"
  deletion_window_in_days = var.key_deletion_window_in_day
  enable_key_rotation     = "true"
  tags = {
    Name = "${var.client_name}-${var.env}-KMS"
    "insurity:resource:type" = "kms-key"
    "insurity:application:role" = "utility"
  }
}

resource "aws_kms_alias" "ebs" {
  name          = "alias/${lower(var.client_name)}-${lower(var.env)}-kms"
  target_key_id = aws_kms_key.ebs.key_id
}
