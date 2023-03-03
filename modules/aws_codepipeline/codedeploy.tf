resource "aws_codedeploy_app" "ec2_code_deploy" {
  name = "ec2_codedeploy"
}

resource "aws_codedeploy_deployment_group" "ec2_group_deploy" {
  app_name              = aws_codedeploy_app.ec2_code_deploy.name
  deployment_group_name = "ec2_codedeploy"
  service_role_arn      = aws_iam_role.ec2_codedeploy.arn

  ec2_tag_set {
    ec2_tag_filter {
      key   = "name"
      type  = "KEY_AND_VALUE"
      value = "web"
    }

  }

}