resource "aws_s3_bucket" "artifact" {
  bucket = "codepipeline-web-artifact"
}
resource "aws_s3_bucket_acl" "artifact_acl" {
  bucket = aws_s3_bucket.artifact.id
  acl    = "private"
}


resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "web-codepipeline"
}

resource "aws_s3_bucket_acl" "codepipeline_bucket_acl" {
  bucket = aws_s3_bucket.codepipeline_bucket.id
  acl    = "private"
}
