resource "null_resource" docker {

  provisioner "remote-exec" {
    inline = [
      "systemctl stop firewalld",
      "systemctl disable firewalld",
      "yum update -y",
      "yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine",
      "yum install -y yum-utils",
      "yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo",
      "yum install docker-ce docker-ce-cli containerd.io -y"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /etc/systemd/system/docker.service.d",
      "cat > /etc/systemd/system/docker.service.d/options.conf<<EOF\n[Service]\nExecStart=\nExecStart=/usr/bin/dockerd -H unix:// -H tcp://0.0.0.0:2375\nEOF"
    ]
  }
  provisioner "remote-exec" {
    inline = [
      "systemctl enable docker",
      "systemctl start docker"
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