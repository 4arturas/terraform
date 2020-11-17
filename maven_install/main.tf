variable "master_node_ip" {
  type = string
  default = "192.168.56.10"
  description = ""
}


resource "null_resource" maven_install {


  provisioner "remote-exec" {
    inline = [
      "wget https://apache.mirror.serveriai.lt/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz",
      "tar -xzf apache-maven-3.6.3-bin.tar.gz",
	  "mkdir /usr/maven",
	  "mv apache-maven-3.6.3 /usr/maven/",
      "echo \"\" >> ~/.bash_profile",
      "echo \"export M2_HOME=/usr/maven/apache-maven-3.6.3\" >> ~/.bash_profile",
      "echo \"export PATH=\\$M2_HOME/bin:\\$PATH\" >> ~/.bash_profile",
      "echo \"export M2=\\$M2_HOME/bin\" >> ~/.bash_profile",
      "source ~/.bash_profile",
      "echo M2_HOME",
      "echo M2"
    ]
  }

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
