variable "master_node_ip" {
  type = string
  default = "192.168.56.10"
  description = ""
}


resource "null_resource" java_install {


  provisioner "remote-exec" {
    inline = [
      "wget https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz",
      "tar -xzf openjdk-11+28_linux-x64_bin.tar.gz",
	  "mkdir /usr/java/jdk-11",
	  "mv jdk-11/ /usr/java/",
      "echo \"\" >> ~/.bash_profile",
      "echo \"export JAVA_HOME=/usr/java/jdk-11\" >> ~/.bash_profile",
      "echo \"export PATH=\\$JAVA_HOME/bin:\\$PATH\" >> ~/.bash_profile",
      "source ~/.bash_profile",
      "echo $JAVA_HOME"
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
