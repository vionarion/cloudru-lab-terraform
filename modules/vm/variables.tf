variable "project_id" {
  type = string
}

variable "zone" {
  type = string
}

variable "name" {
  type = string
}

variable "description" {
  type    = string
  default = null
}

variable "flavor" {
  description = "Flavor name, e.g. gen-2-8 (2 vCPU, 8 GB RAM)."
  type        = string
}

variable "image_id" {
  type = string
}

variable "disk_size" {
  description = "Boot disk size, GB."
  type        = number
}

variable "disk_type" {
  type    = string
  default = "SSD"
}

variable "disk_name" {
  type    = string
  default = null
}

variable "subnet_id" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "ip_address" {
  description = "Fixed private IP inside the subnet."
  type        = string
}

variable "interface_name" {
  type    = string
  default = null
}

variable "public_ip" {
  description = "Attach a public IP to this VM."
  type        = bool
  default     = false
}

variable "public_ip_name" {
  type    = string
  default = null
}
