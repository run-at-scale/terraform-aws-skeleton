terraform {
  required_version = "~> 0.10.6"
}

provider "aws" {
  region  = "${var.region}"
  version = "1.0.0"
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
  # source = "/app/" if running with `docker run -i -t -v $(pwd):/app/ -w /app/examples/test_fixtures hashicorp/terraform:light init`

  source = "../../.."

  region = "${var.region}"

  tags {
    "Terraform" = "true"
    "Env"       = "${terraform.workspace}"
  }
}
