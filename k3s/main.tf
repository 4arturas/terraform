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

variable "token" {
  type = string
  default = "K10c8a531d52b27bc220d2127f737ed905a46db1b8c2b49ac99f5b2f2dfa7756438::server:10529cbff02c82f97502b85d6da20ac5"
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
      "curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC=\"--node-ip=${var.master_node_ip} --flannel-iface=enp0s8\" sh -"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "cat /var/lib/rancher/k3s/server/token"
    ]
  }

//  https://www.youtube.com/watch?v=SLOdZc2uolQ&t=1187s
/*  provisioner "remote-exec" {
    inline = [
	  "hostnamectl set-hostname node1.art.local",
	  "cat <<EOF > /etc/hosts\n127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4\n::1         localhost localhost.localdomain localhost6 localhost6.localdomain6\n\n192.168.56.10 master.art.local master\n192.168.56.11 node1.art.local node1\n192.168.56.12 node2.art.local node2\nEOF",
      "/usr/local/bin/k3s-agent-uninstall.sh",
      "curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC=\"--node-ip=${var.worker_node_ip} --flannel-iface=enp0s8\" K3S_URL=\"https://${var.master_node_ip}:6443\" K3S_TOKEN=\"${var.token}\" sh -"
    ]
  }*/



  connection {
    host     = "${var.master_node_ip}"
//    host     = "${var.worker_node_ip}"
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
