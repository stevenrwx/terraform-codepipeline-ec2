module "vpc" {
  source = "./modules/aws_vpc"

  vpc_cidr_block       = "10.1.0.0/16"
  subnet_public_cidr   = "10.1.1.0/24"
  subnet_public_cidr_2 = "10.1.2.0/24"
  subnet_private_cidr  = "10.1.100.0/24"


}

module "demo" {
  source = "./modules/aws_ec2"

  private_subnet      = module.vpc.private_subnet
  availability_zone  = module.vpc.AZ_2
  security_group_web = module.vpc.security_group_ssh
  instance_type      = "t2.micro"
  create_private_ec2 = true
  create_public_ip   = false
  key_name           = "demo"
  user_data = file("${path.cwd}/scripts/deploy.sh")

}


module "elb" {
  source = "./modules/aws_elb"

  instances = module.demo.private_instance_id
  subnets = [module.vpc.public_subnet, module.vpc.public_subnet2]
  security_group = module.vpc.security_group_ssh

}

module "codepipeline" {
  source = "./modules/aws_codepipeline"

  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.private_subnet
  security_group_ids = module.vpc.security_group_ssh
  repo_name          = "<github_owner>/<repo_name>"
  branch_name        = "<branch_name>"
  github_link        = "https://github.com/<github_owner>/<repo_name>.git"

}