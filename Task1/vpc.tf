module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "vpc"

  cidr = "10.10.0.0/24"
  azs  = slice(data.aws_availability_zones.available.names, 0, 2)

  private_subnets = ["10.10.3.0/27", "10.10.2.0/27"]
  public_subnets  = ["10.10.6.0/27", "10.10.5.0/27"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
  }
}
