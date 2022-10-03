variable "instance_type" {
  description = "instance type t2.micro"
  type        = string
  default     = "t2.micro"
}
variable "instance_count" {
  description = "Ec2 instance count"
  type        = number
  default     = 2
}

