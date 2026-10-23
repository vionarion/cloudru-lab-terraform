module "network" {
  source = "../../modules/network"

  project_id          = var.project_id
  zone                = var.zone
  vpc_id              = var.vpc_id
  subnet_name         = var.subnet_name
  subnet_cidr         = var.subnet_cidr
  gateway             = cidrhost(var.subnet_cidr, 1)
  security_group_name = var.security_group_name
  ssh_allowed_cidrs   = var.ssh_allowed_cidrs
}

module "vm" {
  source   = "../../modules/vm"
  for_each = var.nodes

  project_id         = var.project_id
  zone               = var.zone
  name               = each.value.name
  description        = each.value.description
  flavor             = each.value.flavor
  image_id           = var.image_id
  disk_size          = each.value.disk_size
  disk_name          = each.value.disk_name
  subnet_id          = module.network.subnet_id
  security_group_ids = [module.network.security_group_id]
  ip_address         = each.value.ip_address
  interface_name     = each.value.interface_name
  public_ip          = each.value.public_ip
  public_ip_name     = each.value.public_ip_name
}
