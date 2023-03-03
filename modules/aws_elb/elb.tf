data "aws_availability_zones" "allzones" {}


resource "aws_elb" "elb" {
  name               = "elb"
 # availability_zones = element(["${data.aws_availability_zones.allzones.names}"], 0)
  subnets = var.subnets
  security_groups = var.security_group

  listener {
    instance_port     = 22
    instance_protocol = "TCP"
    lb_port           = 22
    lb_protocol       = "TCP"
  }
  listener {
    instance_port     = 80
    instance_protocol = "TCP"
    lb_port           = 80
    lb_protocol       = "TCP"
  }
  instances                   = [var.instances]
  cross_zone_load_balancing   = true
  idle_timeout                = 100
  connection_draining         = true
  connection_draining_timeout = 100

}

