resource "aws_codebuild_project" "ec2_code_build" {
  name          = "ec2_codebuild"
  description   = "test"
  build_timeout = "5"
  service_role  = aws_iam_role.artifact_role.arn

  artifacts {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type = "S3"
  }


  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:1.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "SOME_KEY1"
      value = "SOME_VALUE1"
    }
  }

  logs_config {
   
    s3_logs {
      status   = "ENABLED"
      location = "${aws_s3_bucket.artifact.id}/build-log"
    }
  }

  source {
    type            = "GITHUB"
    location        = var.github_link
    buildspec = "buildspec.yml"

  }

  source_version = "master"

  vpc_config {
    vpc_id = var.vpc_id

    subnets = [var.subnets]

    security_group_ids = var.security_group_ids
  }

}