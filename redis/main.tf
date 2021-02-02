resource "null_resource" redis {

  provisioner "remote-exec" {
    inline = [
      "systemctl stop firewalld",
      "systemctl disable firewalld",
      "yum install epel-release -y",
      "yum install redis -y",
      "sysctl vm.overcommit_memory=1",
      "echo never > /sys/kernel/mm/transparent_hugepage/enabled",
      "cp /etc/redis.conf /etc/redis.conf.orig",
      "systemctl start redis",
      "systemctl enable redis",
      "systemctl status redis"
      // test redis: redis-cli
      // redis-cli
      // > client list
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
