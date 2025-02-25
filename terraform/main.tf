resource "null_resource" "build_push_docker_image" {
  provisioner "local-exec" {
    command = <<EOT
      gcloud builds submit --tag gcr.io/${var.project_id}/my-app:latest ${path.module}/../application
    EOT
  }
}

terraform {

  backend "gcs" {
    bucket  = "tp-cicd-debacq-bucket"
    prefix  = "terraform/state"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.18.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2.3"
    }
  }
  required_version = ">= 1.5.0"
}


provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}
