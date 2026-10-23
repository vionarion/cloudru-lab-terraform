variable "project_id" {
  description = "cloud.ru Evolution project ID."
  type        = string
}

variable "zone" {
  description = "Availability zone, e.g. ru.AZ-1."
  type        = string
  default     = "ru.AZ-1"
}

variable "vpc_id" {
  description = "VPC the subnet belongs to."
  type        = string
}

variable "subnet_name" {
  description = "Subnet name."
  type        = string
  default     = "subnet-lab"
}

variable "subnet_cidr" {
  description = "Subnet address range."
  type        = string
  default     = "192.168.65.0/24"
}

variable "security_group_name" {
  description = "Security group name."
  type        = string
  default     = "lab-ssh"
}

variable "ssh_allowed_cidrs" {
  description = "Where SSH (22/tcp) is allowed from."
  type        = list(string)
}

variable "image_id" {
  description = "Boot image (Ubuntu 24.04)."
  type        = string
}

variable "nodes" {
  description = "Lab VMs, keyed by short name."
  type = map(object({
    name           = string
    description    = optional(string)
    flavor         = string
    disk_size      = number
    ip_address     = string
    public_ip      = optional(bool, false)
    disk_name      = optional(string)
    interface_name = optional(string)
    public_ip_name = optional(string)
  }))

  validation {
    condition     = length([for n in var.nodes : n if n.public_ip]) == 1
    error_message = "Exactly one node (the bastion) must have a public IP."
  }
}
