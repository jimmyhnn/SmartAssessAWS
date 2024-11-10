resource "aws_s3_bucket" "logs" {
  bucket        = "sample-app-bucket-pvg0vd"
  force_destroy = true
}

resource "aws_s3_object" "app_zip" {
  bucket = aws_s3_bucket.logs.id
  key    = "app.zip"
  source = "app/app.zip"
}
