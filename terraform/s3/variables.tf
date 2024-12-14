variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "tags" {
  description = "Tags to assign to the S3 bucket"
  type        = map(string)
  default     = {}
}