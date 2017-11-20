# Resources defined here
# adding tags can often be accomplished with the following
# tags = "${merge(var.tags, map("Name", format("%s", var.name)))}"

terraform {
  required_version = "> 0.10.6"
}

provider "aws" {
  region  = "${var.region}"
  version = "1.0.0"
}
