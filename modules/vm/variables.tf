variable "project_id" {
  description = "cloud.ru Evolution project ID."
  type        = string
}

variable "zone" {
  description = "Availability zone, e.g. ru.AZ-1."
  type        = string
}

variable "name" {
  description = "VM name."
  type        = string
}

variable "description" {
  description = "VM description."
  type        = string
  default     = null
}

variable "flavor" {
  description = "Flavor name, e.g. gen-2-8 (2 vCPU, 8 GB RAM)."
  type        = string
}

variable "image_id" {
  description = "Boot image ID."
  type        = string
}

variable "disk_size" {
  description = "Boot disk size, GB."
  type        = number
}

variable "disk_type" {
  description = "Disk type name (SSD, HDD)."
  type        = string
  default     = "SSD"
}

variable "disk_name" {
  description = "Boot disk name; defaults to <name>-disk."
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "Subnet for the network interface."
  type        = string
}

variable "security_group_ids" {
  description = "Security groups of the interface."
  type        = list(string)
}

variable "ip_address" {
  description = "Fixed private IP inside the subnet."
  type        = string
}

variable "interface_name" {
  description = "Interface name; defaults to <name>-eth0."
  type        = string
  default     = null
}

variable "public_ip" {
  description = "Attach a public IP to this VM."
  type        = bool
  default     = false
}

variable "public_ip_name" {
  description = "Public IP name; defaults to <name>-ip."
  type        = string
  default     = null
}
