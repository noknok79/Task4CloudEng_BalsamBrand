

provider "aws" {
  region = "us-east-1" # Setting my region to US East. Use your own region here
}

resource "aws_ecr_repository" "markvillaueva-image" {
  name = "markvillanueva-image" # Naming my repository
}

resource "aws_ecs_cluster" "my_cluster" {
  name = "markvillanueva-cluster" # Naming the cluster
}
