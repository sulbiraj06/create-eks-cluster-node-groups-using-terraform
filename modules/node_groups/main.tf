resource "aws_instance" "db-server-instance-1" {
  ami                    = var.db_ec2_ami
  instance_type          = var.db_ec2_inst_type
  subnet_id              = var.ec2_subnet
  vpc_security_group_ids = var.vpc_sec_grp_id
  availability_zone      = var.ec2_az
  key_name               = var.key_name
  root_block_device {
    volume_size           = var.db_root_ebs_size
    volume_type           = "gp3"
    encrypted             = true
    kms_key_id            = var.kms_key
    delete_on_termination = true
  }
  tags = var.tags
}

resource "aws_ebs_volume" "db_D_volume" {
  availability_zone = "us-east-1a"
  size              = 70
  type              = "gp3"
  encrypted         = true
  kms_key_id        = var.kms_key
  #delete_on_termination = true

  tags = {
    Name = "vol-${var.client_name}-${lower(var.env)}-DB-01"
  }
}

resource "aws_volume_attachment" "mountvolumetoec2" {
  device_name = "/dev/sdd"
  instance_id = aws_instance.db-server-instance-1.id
  volume_id   = aws_ebs_volume.db_D_volume.id
}
