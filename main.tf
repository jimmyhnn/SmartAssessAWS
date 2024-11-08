provider "aws" {
  region = "us-west-2" # Replace with your preferred region
}

# Create Elastic Beanstalk application
resource "aws_elastic_beanstalk_application" "app" {
  name = "sample-nodejs-app"
}

# Create Elastic Beanstalk application version
resource "aws_elastic_beanstalk_application_version" "app_version" {
  name        = "v1"                           # Version label
  application = aws_elastic_beanstalk_application.app.name
  bucket      = aws_s3_bucket.logs.id          # Reference your S3 bucket
  key         = "app.zip"                      # Path to the uploaded app in S3
}

# Create Elastic Beanstalk environment
resource "aws_elastic_beanstalk_environment" "env" {
  name                = "sample-nodejs-env"
  application         = aws_elastic_beanstalk_application.app.name
  version_label       = aws_elastic_beanstalk_application_version.app_version.name
  solution_stack_name = "64bit Amazon Linux 2 v3.3.2 running Node.js 14"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.micro"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "NODE_ENV"
    value     = "production"
  }
}
