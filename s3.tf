resource "aws_s3_object" "logs" {
  bucket = "sample-app-bucket-${random_string.suffix.result}"
}

resource "aws_s3_object" "app_zip" {
  bucket = aws_s3_bucket.logs.id
  key    = "app.zip"
  source = "app/app.zip" # Path to the app zip file
}