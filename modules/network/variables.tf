variable "project_id" {
  type = string
}

variable "zone" {
  type = string
}

variable "vpc_id" {
  description = "VPC the subnet belongs to."
  type        = string
}

variable "subnet_name" {
  type = string
}

variable "subnet_cidr" {
  type = string
}

variable "gateway" {
  type = string
}

variable "dns_servers" {
  type    = list(string)
  default = ["8.8.8.8"]
}

variable "security_group_name" {
  type = string
}

variable "security_group_description" {
  type    = string
  default = "allow ssh access"
}

variable "ssh_allowed_cidrs" {
  description = "Where SSH (22/tcp) is allowed from."
  type        = list(string)

  validation {
    condition     = alltrue([for c in var.ssh_allowed_cidrs : can(cidrhost(c, 0))])
    error_message = "Every entry must be a CIDR, e.g. 203.0.113.10/32."
  }
}
