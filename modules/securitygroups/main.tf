# Security Group for G2 app server instance
resource "aws_security_group" "G2-sg" {
  vpc_id      = var.security_group_vpc_id
  name        = "${var.client_name}-${var.env}-G2-secgrp"
  description = "Security Group for G2 instance"

  ingress {
    description = "OpenVPN traffic"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["${var.openvpn_ip}/32"]
  }
  ingress {
    description = "Primary Domain Controller traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.dc_ip}/32"]
  }
  ingress {
    description = "Secondary Domain Controller traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.adc_ip}/32"]
  }
  ingress {
    description     = "G2 elb traffic"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.g2-alb-sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.client_name}-${var.env}-G2-secgrp"
  }
}

# Security Group for ETM server instance
resource "aws_security_group" "etm-sg" {
  vpc_id      = var.security_group_vpc_id
  name        = "${var.client_name}-${var.env}-ETM-secgrp"
  description = "Security Group for ETM instance"

  ingress {
    description = "OpenVPN traffic"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["${var.openvpn_ip}/32"]
  }
  ingress {
    description = "Primary Domain Controller traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.dc_ip}/32"]
  }
  ingress {
    description = "Secondary Domain Controller traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.adc_ip}/32"]
  }
  ingress {
    description = "Termial Server traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.ts_ip}/32"]
  }
  ingress {
    description = "G2-01 traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.g2_ip1}/32"]
  }
  ingress {
    description = "G2-02 traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.g2_ip2}/32"]
  }
  ingress {
    description     = "ETM elb traffic"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.etm-alb-sg.id]
  }
  ingress {
    description     = "ETM internal elb traffic"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.etm-int-alb-sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.client_name}-${var.env}-ETM-secgrp"
  }
}

# Security Group for database server instance

resource "aws_security_group" "db-sg" {
  vpc_id      = var.security_group_vpc_id
  name        = "${var.client_name}-${var.env}-DB-secgrp"
  description = "Security Group for DB instance"
  ingress {
    description = "OpenVPN traffic"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["${var.openvpn_ip}/32"]
  }
  ingress {
    description = "Primary Domain Controller traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.dc_ip}/32"]
  }
  ingress {
    description = "Secondary Domain Controller traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.adc_ip}/32"]
  }
  ingress {
    description = "Termial Server traffic"
    from_port   = 1443
    to_port     = 1443
    protocol    = "tcp"
    cidr_blocks = ["${var.ts_ip}/32"]
  }
  ingress {
    description = "ETM 01 traffic"
    from_port   = 1443
    to_port     = 1443
    protocol    = "tcp"
    cidr_blocks = ["${var.etm_ip1}/32"]
  }
  ingress {
    description = "ETM 02 traffic"
    from_port   = 1443
    to_port     = 1443
    protocol    = "tcp"
    cidr_blocks = ["${var.etm_ip2}/32"]
  }
  ingress {
    description = "G2-01 traffic"
    from_port   = 1443
    to_port     = 1443
    protocol    = "tcp"
    cidr_blocks = ["${var.g2_ip1}/32"]
  }
  ingress {
    description = "G2-02 traffic"
    from_port   = 1443
    to_port     = 1443
    protocol    = "tcp"
    cidr_blocks = ["${var.g2_ip2}/32"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.client_name}-${var.env}-DB-secgrp"
  }
}


# ETM ALB Security Group: Edit to restrict access to the application
### 1)
resource "aws_security_group" "etm-alb-sg" {
  name        = "${var.client_name}-${var.env}-ETM-ALB-secgrp"
  description = "controls access to the ETM ALB"
  vpc_id      = var.security_group_vpc_id

  # ingress {
  #   protocol    = "tcp"
  #   from_port   = var.app_port
  #   to_port     = var.app_port
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.client_name}-${var.env}-ETM-ALB-secgrp"
  }
}

### 2)
resource "aws_security_group" "etm-int-alb-sg" {
  name        = "${var.client_name}-${var.env}-ETM-int-ALB-secgrp"
  description = "controls access to the ETM Internal ALB"
  vpc_id      = var.security_group_vpc_id

  ingress {
    description = "G2 01 traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.g2_ip1}/32"]
  }
  ingress {
    description = "G2 02 traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.g2_ip2}/32"]
  }
  ingress {
    description = "ETM 01 traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.etm_ip1}/32"]
  }
  ingress {
    description = "ETM 02 traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.etm_ip2}/32"]
  }
  ingress {
    description = "Termial Server traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.ts_ip}/32"]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.client_name}-${var.env}-ETM-int-ALB-secgrp"
  }
}

# G2 ALB Security Group: Edit to restrict access to the application
resource "aws_security_group" "g2-alb-sg" {
  name        = "${var.client_name}-${var.env}-G2-ALB-secgrp"
  description = "controls access to the G2 ALB"
  vpc_id      = var.security_group_vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = var.app_port
    to_port     = var.app_port
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.client_name}-${var.env}-G2-ALB-secgrp"
  }
}

# # ALB Security Group: Edit to restrict access to the application
# resource "aws_security_group" "alb-sg" {
#   name        = "${var.client_name}-${var.env}-ALB-security-group"
#   description = "controls access to the ALB"
#   vpc_id      = var.security_group_vpc_id

#   ingress {
#     protocol    = "tcp"
#     from_port   = var.app_port
#     to_port     = var.app_port
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     protocol    = "-1"
#     from_port   = 0
#     to_port     = 0
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "${var.client_name}-${var.env}-ALB-security-group"
#   }
# }


# SST Logic monitor security group for MGMT VPC

resource "aws_security_group" "SST-LM-sg" {
  name        = "${var.client_name}-${var.env}-SST-LM-secgrp"
  description = "SST Logic monitor security group"
  vpc_id      = var.security_group_vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 137
    to_port     = 139
    cidr_blocks = ["${var.sst_lm_ip}/32"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 135
    to_port     = 135
    cidr_blocks = ["${var.sst_lm_ip}/32"]
  }
  ingress {
    protocol    = "icmp"
    from_port   = -1
    to_port     = -1
    cidr_blocks = ["${var.sst_lm_ip}/32"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 10100
    to_port     = 10200
    cidr_blocks = ["${var.sst_lm_ip}/32"]
  }
  ingress {
    protocol    = "udp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["${var.sst_lm_ip}/32"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["${var.sst_lm_ip}/32"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 1433
    to_port     = 1433
    cidr_blocks = ["${var.sst_lm_ip}/32"]
  }
  ingress {
    protocol    = "udp"
    from_port   = 1434
    to_port     = 1434
    cidr_blocks = ["${var.sst_lm_ip}/32"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 445
    to_port     = 445
    cidr_blocks = ["${var.sst_lm_ip}/32"]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["${var.sst_lm_ip}/32"]
  }

  tags = {
    Name = "${var.client_name}-${var.env}-SST-LM-sec-grp"
  }
}