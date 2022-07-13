
variable "tfc_organization" {
  description = "The Terraform Cloud organization name"
  default     = "waypoint"
}

# object type
variable "tfc_workspace_name" {
  type        = string
  description = "The Terraform Cloud workspace name"
  default     = "api-lambda-aurora-go"

}

################################################################################
# VARIABLES — These are/should be set in Terraform Cloud
################################################################################
variable "vpc_name" {
  type    = string
  default = "default"
}

variable "db_subnet_group_name" {
  type = string
}

variable "vpc_security_group_ids" {
  type    = list(string)
  default = []
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}
