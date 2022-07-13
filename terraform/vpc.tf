module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"


  create_vpc = false

  manage_default_vpc               = true
  default_vpc_name                 = var.vpc_name
  default_vpc_enable_dns_hostnames = true
}
