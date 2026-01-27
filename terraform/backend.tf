terraform {
  backend "gcs" {
    bucket = "spark-terraform-state-spark-automation-tp-482009"
    prefix = "terraform/state"
  }
}
