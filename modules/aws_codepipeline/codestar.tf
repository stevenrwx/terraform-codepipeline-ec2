resource "aws_codestarconnections_connection" "gh_codestar" {
  name          = "github token"
  provider_type = "GitHub"
}