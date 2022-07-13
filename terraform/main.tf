# CLI driven workflow
terraform {
  cloud {
    organization = "waypoint"
    workspaces {
      name = "api-lambda-aurora-go"
    }
  }
}

locals {
  name   = var.tfc_workspace_name
  region = var.aws_region
  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}

provider "aws" {
  region = local.region
}

