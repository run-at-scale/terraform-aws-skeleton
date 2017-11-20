/*
Module variables
*/

variable "tags" {
  description = "A map of tags to add to all resources."
  default     = {}
}

variable "foo" {
  description = "An example variable to be consumed for tests and resources."
  default     = "bar"
}

variable "baz" {
  description = "An example variable to be consumed for tests and resources."
  default     = "qux"
}

variable "region" {}

variable "list_input_output" {
  type    = "list"
  default = ["1", "2", 3]
}

variable "map_input_output" {
  type = "map"

  default = {
    foo = "bar"
    baz = "bomb"
  }
}
