# terraform-codepipeline-ec2
Creates a Codepipeline that deploys the code from github -> EC2 instance
- **The configuration requires github token to be authenticated, to enable go to Codepipeline service in console -> settings -> connections (update pending connection)**

## replace values <>
- replace <github_owner>
- replace <repo_name>
- replace <branch_name>

## Infrastructure components
main.tf contains the vpc, ec2, elb and codepipeline

- VPC: 2 public subnets and 1 private subnet using natgateway for internet connectivity outbound
- EC2: creates 1 ec2 instance in public subnet with port 80 & 22 open also sshkey is created
- elb: creates public dns (A record) and routes traffic to private EC2 instance on port 80 and 22
- Codepipeline: creates "tf-test-pipeline" with 3 phases
- source: pulls github updates from the repo and branch then stores it as [SourceArtifact]
- build: runs build instructions in the builspec.yml located in the target github then stores it as [BuildArtifact]
- deploy: takes the [BuildArtifact] in the build phase and deploys it on the EC2 using the codedeploy-agent, the appspec.yml located in the target github can contain steps for the lifecycle of the application

## Terraform modules
located in the ./modules/ path


## Buildspec
- determines the steps of building the application and running tests if needed within a container
Must be located in the the root directory of the repo 
- ref: https://docs.aws.amazon.com/codebuild/latest/userguide/build-spec-ref.html

```
version: 0.2

phases:
  install:
    run-as: root
    on-failure: ABORT
    runtime-versions:
      docker: 18
      python: 3.8
    commands:
      - echo "some tests ect..."

artifacts:
  files:
    - "**/*"
  name: build-$(date +%Y-%m-%d)

```
## Appspec
- determines the lifecycle of the deployment e.g. starting or stopping the application on EC2
Must be located in the the root directory of the repo 
- ref: https://docs.aws.amazon.com/codedeploy/latest/userguide/reference-appspec-file.html
```
version: 0.0
os: linux
files:
  - source: /
    destination: /home/ubuntu/dev
```

## Useful commands
- `sudo make install` shows the expected output of 34 resources
- `sudo make install-approve` 
- `sudo make destroy`

## expected results
- Created private EC2 with port 80 and 22 open
- Created elb that connects to the private ec2
- Codepipeline deploys the github repo to the private EC2
