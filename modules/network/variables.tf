variable "project_id" {
  description = "cloud.ru Evolution project ID."
  type        = string
}

variable "zone" {
  description = "Availability zone, e.g. ru.AZ-1."
  type        = string
}

variable "vpc_id" {
  description = "VPC the subnet belongs to."
  type        = string
}

variable "subnet_name" {
  description = "Subnet name."
  type        = string
}

variable "subnet_cidr" {
  description = "Subnet address range."
  type        = string
}

variable "gateway" {
  description = "Default gateway inside the subnet."
  type        = string
}

variable "dns_servers" {
  description = "DNS servers handed out in the subnet."
  type        = list(string)
  default     = ["8.8.8.8"]
}

variable "security_group_name" {
  description = "Security group name."
  type        = string
}

variable "security_group_description" {
  description = "Security group description."
  type        = string
  default     = "allow ssh access"
}

variable "ssh_allowed_cidrs" {
  description = "Where SSH (22/tcp) is allowed from."
  type        = list(string)

  validation {
    condition     = alltrue([for c in var.ssh_allowed_cidrs : can(cidrhost(c, 0))])
    error_message = "Every entry must be a CIDR, e.g. 203.0.113.10/32."
  }
}
