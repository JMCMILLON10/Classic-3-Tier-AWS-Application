variable "vpc_cidr" {
  type    = string
  default = "10.169.0.0/16"
}

variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"] # cost-minimal (2 AZ)
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.169.1.0/24", "10.169.2.0/24"]
}

variable "private_app_subnet_cidrs" {
  type    = list(string)
  default = ["10.169.11.0/24", "10.169.12.0/24"]
}

variable "private_db_subnet_cidrs" {
  type    = list(string)
  default = ["10.169.21.0/24", "10.169.22.0/24"]
}
