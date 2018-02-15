terraform {
  required_version = "~> 0.10.8"
}

provider "aws" {
  version = "~> 1.0.0"
}

resource "null_resource" "debug_echo" {
  triggers {
    uuid = "${uuid()}"
  }

  provisioner "local-exec" {
    command = "echo ${path.module}"
  }
}

module "main" {
  source = "../../.."
  region = "${var.region}"

  tags {
    "Terraform" = "true"
    "Env"       = "${terraform.workspace}"
  }
}
