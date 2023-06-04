variable "vpc_cidr" {
  description = "cidr_block of the main VPC"
  default     = "10.0.0.0/16"
}
variable "client_name" {
  
}
variable "tenancy" {
  description = "tenancy of the main VPC"
  default     = "default"
}
variable "cidr_pub_sub" {
  type    = list(any)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}
variable "cidr_priv_sub" {
  type    = list(any)
  default = ["10.0.5.0/24", "10.0.6.0/24"]
}
variable "subnet_azs" {
  type    = list(any)
  default = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
}
variable "db_ec2_ami" {
  default = ""
}
variable "db_ec2_inst_type" {
  default = ""
}
variable "db_root_ebs_size" {
  default = ""
}
variable "ec2_sec_grp_id" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = null
}
variable "ec2_az" {
  default = ""
}
variable "aws_region" {
  default     = "us-east-1"
  description = "aws region where our resources going to create choose"
  #replace the region as suits for your requirement
}
variable "app_port" {
  default = "80"
}
variable "health_check_path" {
  default = "/"
}
variable "env" {
  type = string
}
variable "vpc_sec_grp_id" {
  default     = "null"
  description = "sec grp id"
}
variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
variable "ec2_subnet" {
  default = null
}
variable "key_name" {
  type = string
}
variable "term_root_ebs_size" {
  default = ""
}
variable "kms_key" {
  default = ""
}