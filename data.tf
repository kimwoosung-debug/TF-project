data "aws_vpc" "selected" {
  tags = {
    Name = "sample-vpc"
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }

  tags = {
    Name = "*public*"
  }
}

