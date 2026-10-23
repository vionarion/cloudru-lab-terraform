resource "cloudru_evolution_compute_subnet" "this" {
  project_id      = var.project_id
  vpc_id          = var.vpc_id
  name            = var.subnet_name
  subnet_address  = var.subnet_cidr
  default_gateway = var.gateway
  routed_network  = true
  default         = true

  dns_servers = {
    value = var.dns_servers
  }

  zone = {
    name = var.zone
  }
}

resource "cloudru_evolution_compute_security_group" "this" {
  project_id  = var.project_id
  name        = var.security_group_name
  description = var.security_group_description

  zone = {
    name = var.zone
  }
}

resource "cloudru_evolution_compute_security_group_rule" "ssh" {
  for_each = toset(var.ssh_allowed_cidrs)

  security_group_id = cloudru_evolution_compute_security_group.this.id
  description       = "SSH"
  direction         = "TRAFFIC_DIRECTION_INGRESS"
  ether_type        = "ETHER_TYPE_IPV4"
  ip_protocol       = "IP_PROTOCOL_TCP"
  port_range        = "22:22"
  remote_ip_prefix  = each.value
}

# Nodes talk to each other freely (Kubernetes, etcd/Raft, overlay network).
resource "cloudru_evolution_compute_security_group_rule" "intra" {
  security_group_id = cloudru_evolution_compute_security_group.this.id
  description       = "All ingress IPv4 from default group"
  direction         = "TRAFFIC_DIRECTION_INGRESS"
  ether_type        = "ETHER_TYPE_IPV4"
  ip_protocol       = "IP_PROTOCOL_ANY"
  port_range        = "any"

  remote_security_group = {
    id = cloudru_evolution_compute_security_group.this.id
  }
}

resource "cloudru_evolution_compute_security_group_rule" "egress" {
  security_group_id = cloudru_evolution_compute_security_group.this.id
  description       = "All egress IPv4"
  direction         = "TRAFFIC_DIRECTION_EGRESS"
  ether_type        = "ETHER_TYPE_IPV4"
  ip_protocol       = "IP_PROTOCOL_ANY"
  port_range        = "any"
  remote_ip_prefix  = "0.0.0.0/0"
}
