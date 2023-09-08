module "ecs" {
  source = "./modules/ecs-cluster"
  vpc_id = "vpc-0c8d294b31882c704"

  private_subnets = ["subnet-0fe54d52751dd15c4", "subnet-0402cdbddc07916d5", "subnet-03c62e60e5d27d32d", "subnet-0957c53dc12e38e7f"]
  public_subnets  = ["subnet-04a00c359a455a4a8", "subnet-026b72d5cced8fddc"]

}
