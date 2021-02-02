variable "master_node_ip" {
  type = string
  default = "192.168.56.10"
  description = ""
}
variable "worker_node_ip" {
  type = string
  default = "192.168.56.11"
  description = ""
}

variable "K3S_VERSION" {
  type = string
  default = "v1.20.2-rc1+k3s1"
  description = ""
}

variable "token" {
  type = string
  default = "K107a49ae322313aab0016cfa2416dc102137f4533b77c7453b4f541f39368915d3::server:2d2a83d78249d9e7e1e747f55452475d"
  description = ""
}

resource "null_resource" k3s_worker {


  provisioner "remote-exec" {
    inline = [
      "systemctl stop firewalld",
      "systemctl disable firewalld"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "yum update -y"
    ]
  }

    provisioner "remote-exec" {
      inline = [
        "hostnamectl set-hostname node1.art.local",
        "cat <<EOF > /etc/hosts\n127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4\n::1         localhost localhost.localdomain localhost6 localhost6.localdomain6\n\n192.168.56.10 master.art.local master\n192.168.56.11 node1.art.local node1\n192.168.56.12 node2.art.local node2\nEOF",
        "/usr/local/bin/k3s-agent-uninstall.sh",
        "curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC=\"--node-ip=${var.worker_node_ip} --flannel-iface=enp0s8\" K3S_URL=\"https://${var.master_node_ip}:6443\" K3S_TOKEN=\"${var.token}\" INSTALL_K3S_VERSION=${var.K3S_VERSION} sh -"
      ]
    }


  connection {
    host     = "${var.worker_node_ip}"
    type     = "ssh"
    user     = "root"
    password = "x"
    agent    = "false"
  }
}


/*
output "ip" {
  value = "${var.k3s_token}"
}*/
