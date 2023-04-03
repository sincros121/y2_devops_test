terraform {
  backend "s3" {
    bucket = "tf-state-test"
    region = "us-east-1"
    key    = "state/tf.tfstate"
  }
}
