variable "master_node_ip" {
  type = string
  default = "192.168.56.10"
  description = ""
}

variable "K3S_VERSION" {
  type = string
  default = "v1.20.2-rc1+k3s1"
  description = ""
}

resource "null_resource" k3s_master {


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
	  "hostnamectl set-hostname master.art.local",
      "echo \"192.168.56.10 master.art.local master\" >> /etc/hosts",
      "echo \"192.168.56.11 node1.art.local node1\" >> /etc/hosts",
      "echo \"192.168.56.12 node2.art.local node2\" >> /etc/hosts",
      "/usr/local/bin/k3s-uninstall.sh",
      "curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC=\"--node-ip=${var.master_node_ip} --flannel-iface=enp0s8\" INSTALL_K3S_VERSION=${var.K3S_VERSION} sh -"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "cat /var/lib/rancher/k3s/server/token"
    ]
  }

  connection {
    host     = "${var.master_node_ip}"
    type     = "ssh"
    user     = "root"
    password = "x"
    agent    = "false"
  }
}
