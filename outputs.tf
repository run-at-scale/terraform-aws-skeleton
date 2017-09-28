output "an_id" {
  description = "The ID of a resource we created."
  value       = "${aws_resource.main.id}"
}
