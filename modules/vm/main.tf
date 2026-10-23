locals {
  disk_name      = coalesce(var.disk_name, "${var.name}-disk")
  interface_name = coalesce(var.interface_name, "${var.name}-eth0")
  public_ip_name = coalesce(var.public_ip_name, "${var.name}-ip")
}

resource "cloudru_evolution_compute_disk" "boot" {
  project_id = var.project_id
  name       = local.disk_name
  size       = var.disk_size
  bootable   = true
  encrypted  = false
  readonly   = false
  shared     = false

  disk_type = {
    name = var.disk_type
  }

  image = {
    id = var.image_id
  }

  zone = {
    name = var.zone
  }
}

resource "cloudru_evolution_compute_external_ip" "this" {
  count = var.public_ip ? 1 : 0

  project_id = var.project_id
  name       = local.public_ip_name

  zone = {
    name = var.zone
  }

  # The link is owned by the interface (attach_external_ip); the API mirrors it back here.
  lifecycle {
    ignore_changes = [network_interface]
  }
}

resource "cloudru_evolution_compute_interface" "this" {
  project_id                 = var.project_id
  name                       = local.interface_name
  type                       = "INTERFACE_TYPE_REGULAR"
  ip_address                 = var.ip_address
  interface_security_enabled = true

  subnet = {
    id = var.subnet_id
  }

  security_groups = [for id in var.security_group_ids : { id = id }]

  attach_external_ip = var.public_ip ? { id = cloudru_evolution_compute_external_ip.this[0].id } : null

  zone = {
    name = var.zone
  }

  # The VM attaches the interface (network_interfaces); the API mirrors it back here.
  lifecycle {
    ignore_changes = [vm]
  }
}

resource "cloudru_evolution_compute_vm" "this" {
  project_id  = var.project_id
  name        = var.name
  description = var.description

  flavor = {
    name = var.flavor
  }

  zone = {
    name = var.zone
  }

  disks = [{ id = cloudru_evolution_compute_disk.boot.id }]

  network_interfaces = [{ id = cloudru_evolution_compute_interface.this.id }]
}
