data "aws_rds_engine_version" "postgresql" {
  engine  = "aurora-postgresql"
  version = "13.6"
}

module "aurora_postgresql_serverlessv2" {
  source = "terraform-aws-modules/rds-aurora/aws"

  name                = "${local.name}-postgresqlv2"
  engine              = data.aws_rds_engine_version.postgresql.engine
  engine_version      = data.aws_rds_engine_version.postgresql.version
  engine_mode         = "serverless"
  storage_encrypted   = true
  publicly_accessible = true

  create_db_subnet_group = false
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_id                 = module.vpc.vpc_id
  subnets                = module.vpc.database_subnets
  vpc_security_group_ids = var.vpc_security_group_ids
  create_security_group  = true
  allowed_cidr_blocks    = module.vpc.private_subnets_cidr_blocks

  monitoring_interval = 60

  apply_immediately   = true
  skip_final_snapshot = true

  db_parameter_group_name         = aws_db_parameter_group.example_postgresql13.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.example_postgresql13.id

  serverlessv2_scaling_configuration = {
    min_capacity = 0.5
    max_capacity = 2
  }

  instance_class = "db.serverless"
  instances = {
    one = {}
    # two = {}
  }
}

resource "aws_db_parameter_group" "example_postgresql13" {
  name        = "${local.name}-aurora-db-postgres13-parameter-group"
  family      = "aurora-postgresql13"
  description = "${local.name}-aurora-db-postgres13-parameter-group"
  tags        = local.tags
}

resource "aws_rds_cluster_parameter_group" "example_postgresql13" {
  name        = "${local.name}-aurora-postgres13-cluster-parameter-group"
  family      = "aurora-postgresql13"
  description = "${local.name}-aurora-postgres13-cluster-parameter-group"
  tags        = local.tags
}
