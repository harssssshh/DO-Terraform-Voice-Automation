resource "digitalocean_kubernetes_cluster" "foo" {
  name = "foo"
  region  = "blr1"
  version = "1.18.8-do.0"
  tags    = ["staging"]

  node_pool {
    name       = "worker-pool"
    size       = "s-1vcpu-2gb"
    node_count = 2
  }
}


provider "kubernetes" {
  host = "${digitalocean_kubernetes_cluster.foo.endpoint}"
  client_certificate     = "${base64decode(digitalocean_kubernetes_cluster.foo.kube_config.0.client_certificate)}"
  client_key             = "${base64decode(digitalocean_kubernetes_cluster.foo.kube_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(digitalocean_kubernetes_cluster.foo.kube_config.0.cluster_ca_certificate)}"
}

output "cluster-id" {
  value = "${digitalocean_kubernetes_cluster.foo.id}"
}
