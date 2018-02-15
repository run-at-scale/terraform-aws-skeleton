/*
Module variables
*/

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = "map"
  default     = {}
}

variable "foo" {
  description = "An example variable to be modified within tests."
  default     = "bar"
}

variable "baz" {
  description = "Another example variable but without a default."
  type        = "string"
}

variable "list_with_defaults" {
  description = "A list variable with defaults provided."
  type        = "list"
  default     = ["1", "2", "3"]
}

variable "list_without_defaults" {
  description = "A list variable with defaults provided."
  type        = "list"
}

variable "map_without_defaults" {
  description = "An example of a map used to store default values."
  type        = "map"
}
