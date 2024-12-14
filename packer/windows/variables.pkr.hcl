variable "region" {
  description = "The AWS region to launch the EC2 instance"
  type        = string
  default     = "ap-southeast-2"
}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
  default     = "t2.micro"
}

variable "ami_owners" {
  description = "The allowed owners of the AMI"
  type        = list(string)
  default     = ["amazon"]
}

variable "windows_version" {
    description = "The version of the Windows distribution"
    type        = string
    default     = "2019"
}