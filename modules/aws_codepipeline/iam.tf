resource "aws_iam_role" "artifact_role" {
  name = "codebuild_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "ec2_policy" {
  role = aws_iam_role.artifact_role.name

  policy = <<POLICY
{
	"Version": "2012-10-17",
	"Statement": [{
			"Effect": "Allow",
			"Resource": [
				"*"
			],
			"Action": [
				"logs:CreateLogGroup",
				"logs:CreateLogStream",
				"logs:PutLogEvents"
			]
		},
		{
			"Effect": "Allow",
			"Action": [
				"ec2:CreateNetworkInterface",
				"ec2:CreateNetworkInterfacePermission",
				"ec2:DescribeDhcpOptions",
				"ec2:DescribeNetworkInterfaces",
				"ec2:DeleteNetworkInterface",
				"ec2:DescribeSubnets",
				"ec2:DescribeSecurityGroups",
				"ec2:DescribeVpcs"
			],
			"Resource": "*"
		},
		{
			"Effect": "Allow",
			"Action": [
				"codebuild:*",
        "ec2:*",
        "codestar-connections:UseConnection",
        "s3:*",
				"iam:PassRole"
			],
			"Resource": "*"
		},
		{
			"Effect": "Allow",
			"Action": [
				"s3:PutObject",
				"s3:GetObject",
				"s3:GetObjectVersion",
				"s3:GetBucketAcl",
				"s3:GetBucketLocation",
				"s3:CreateBucket",
				"s3:GetObject",
				"s3:List*",
        "s3:*"
			],
			"Resource": [
				"${aws_s3_bucket.artifact.arn}",
				"${aws_s3_bucket.artifact.arn}/*",
        		"${aws_s3_bucket.codepipeline_bucket.arn}",
				"${aws_s3_bucket.codepipeline_bucket.arn}/*"
			]
		}
	]
}
POLICY
}

resource "aws_iam_role" "ec2_codedeploy" {
  name = "ec2_codedeploy"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codedeploy.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  role       = aws_iam_role.ec2_codedeploy.name
}


resource "aws_iam_role" "codepipeline_role" {
  name = "test-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "codepipeline_policy"
  role = aws_iam_role.codepipeline_role.id

  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [{
			"Effect": "Allow",
			"Action": [
				"s3:GetObject",
				"s3:GetObjectVersion",
				"s3:GetBucketVersioning",
				"s3:PutObjectAcl",
				"s3:PutObject",
        "s3:*"
			],
			"Resource": [
				"${aws_s3_bucket.codepipeline_bucket.arn}",
				"${aws_s3_bucket.codepipeline_bucket.arn}/*"
			]
		},
		{
			"Effect": "Allow",
			"Action": [
				"codestar-connections:UseConnection"
			],
			"Resource": "${aws_codestarconnections_connection.gh_codestar.arn}"
		},
		{
			"Effect": "Allow",
			"Action": [
				"codebuild:BatchGetBuilds",
				"codebuild:StartBuild",
        "codebuild:*"
			],
			"Resource": "*"
		},
		{
			"Effect": "Allow",
			"Action": [
				"codedeploy:CreateDeployment",
				"codedeploy:GetDeployment"
			],
			"Resource": [
				"${aws_codedeploy_deployment_group.ec2_group_deploy.arn}"
			]
		},
		{
			"Effect": "Allow",
			"Action": [
				"codedeploy:GetDeploymentConfig"
			],
			"Resource": [
				"*"
			]
		},
		{
			"Effect": "Allow",
			"Action": [
				"codedeploy:GetApplicationRevision",
				"codedeploy:RegisterApplicationRevision"
			],
			"Resource": [
				"${aws_codedeploy_app.ec2_code_deploy.arn}"
			]
		}
	]
}
EOF
}