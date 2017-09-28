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
