default_vpc_id             = "vpc-074d8b43ff7a9020c"
default_vpc_cidr           = "172.31.0.0/16"
default_vpc_route_table_id = "rtb-0a912ce6b1f56e5a1"
zone_id                    = "Z050201124IFD7TBJ5IEA"
env                        = "dev"
acm_certificate_arn        = "arn:aws:acm:us-east-1:571600849080:certificate/9625da36-8db8-46c6-b736-5f9a53878c04"


tags = {
  company_name  = "Taski"
  business_unit = "transportation"
  created_by    = "terraform"
}


vpc = {
  main = {
    cidr = "10.0.0.0/16"
    subnets = {
      public = {
        public1 = { cidr = "10.0.0.0/24", az = "us-east-1a" }
        public2 = { cidr = "10.0.1.0/24", az = "us-east-1b" }
      }
      app = {
        app1 = { cidr = "10.0.2.0/24", az = "us-east-1a" }
        app2 = { cidr = "10.0.3.0/24", az = "us-east-1b" }
      }
      db = {
        db1 = { cidr = "10.0.4.0/24", az = "us-east-1a" }
        db2 = { cidr = "10.0.5.0/24", az = "us-east-1b" }
      }
    }
  }
}
alb = {
  public = {
    internal        = false
    lb_type         = "application"
    sg_ingress_cidr = ["0.0.0.0/0"]
    sg_port         = 443
  }

  private = {
    internal        = true
    lb_type         = "application"
    sg_ingress_cidr = ["172.31.0.0/16", "10.0.0.0/16"]
    sg_port         = 80
  }
}
#
docdb = {
  main = {
    backup_retention_period = 5
    preferred_backup_window = "07:00-09:00"
    skip_final_snapshot     = true
    engine_version          = "4.0.0"
    engine_family           = "docdb4.0"
    instance_count          = 1
    instance_class          = "db.t3.medium"
  }
}

rds = {
  main = {
    rds_type                = "mysql"
    db_port                 = 3306
    engine_family           = "aurora-mysql5.7"
    engine                  = "aurora-mysql"
    engine_version          = "5.7.mysql_aurora.2.11.3"
    backup_retention_period = 5
    preferred_backup_window = "07:00-09:00"
    skip_final_snapshot     = true
    instance_count          = 1
    instance_class          = "db.t3.small"
  }
}
