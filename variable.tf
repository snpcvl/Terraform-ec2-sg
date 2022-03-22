variable "cidr" {
  default       = "172.16.0.0/16"
  description   = "VPC CIDR Block"
  type          = string
}
variable "subnet" {
  default       = "172.16.10.0/24"
  description   = "VPC CIDR Block"
  type          = string
}
