resource "null_resource" remoteExecProvisionerWFolder {

  provisioner "file" {
    source      = "C:/Users/Art/Desktop/lxd/terraform.txt"
    destination = "/tmp/test.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "pwd",
      "rm -rf /tmp/test.txt",
    ]
  }

  connection {
    host     = "192.168.56.10"
    type     = "ssh"
    user     = "root"
    password = "x"
    agent    = "false"
  }
}