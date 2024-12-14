variable "distribution" {
  description = "The name of the Linux distribution"
  type        = string
  default     = "debian"
}

variable "distribution_version" {
  description = "The version of the Linux distribution"
  type        = string
  default     = "12"
}

variable "ami_owners" {
  description = "The allowed owners of the AMI"
  type        = list(string)
  default     = ["amazon"]
}

variable "ami_architecture" {
  description = "The architecture of the AMI"
  type        = string
  default     = "amd64"
}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
  default     = "t2.micro"
}

variable "ssh_username" {
  description = "The SSH username for the EC2 instance"
  type        = string
  default     = "admin"
}

variable "region" {
  description = "The AWS region to launch the EC2 instance"
  type        = string
  default     = "ap-southeast-2"
}
