variable "master_node_ip" {
  type = string
  default = "192.168.56.10"
  description = ""
}
resource "null_resource" install_confluent_on_centos7 {

  provisioner "remote-exec" {
    inline = [
      "systemctl stop firewalld",
      "systemctl disable firewalld",
      "sudo yum update -y",
      "sudo yum install curl which -y",
      "sudo rpm --import https://packages.confluent.io/rpm/6.0/archive.key",
      "touch /etc/yum.repos.d/confluent.repo",
    ]
  }

  provisioner "file" {
    source      = "confluent.repo"
    destination = "/etc/yum.repos.d/confluent.repo"
  }



  provisioner "remote-exec" {
    inline = [
      "sudo yum clean all && sudo yum install confluent-platform -y",
      "sudo yum install java-11-openjdk-devel -y",
      "confluent-hub install --no-prompt confluentinc/kafka-connect-datagen:latest"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "nohup /usr/bin/zookeeper-server-start /etc/kafka/zookeeper.properties > zookeeper.out",
      "nohup /usr/bin/kafka-server-start /etc/kafka/server.properties > server.out",
      "nohup /usr/bin/schema-registry-start /etc/schema-registry/schema-registry.properties > schema-registry.out",
      "nohup /usr/bin/control-center-start /etc/confluent-control-center/control-center.properties > control-center.out",
      "nohup /usr/bin/connect-distributed /etc/schema-registry/connect-avro-distributed.properties > connect-avro-distributed.out",
      "nohup /usr/bin/kafka-rest-start /etc/kafka-rest/kafka-rest.properties > kafka-rest.out",
      "nohup /usr/bin/ksql-server-start /etc/ksqldb/ksql-server.properties > ksql-server.out",
    ]
  }
/*  provisioner "file" {
    source      = "zookeeper.properties"
    destination = "/etc/kafka/zookeeper-MY.properties"
  }*/
/*

  provisioner "remote-exec" {
    inline = [
      "sudo systemctl enable confluent-zookeeper",
      "sudo systemctl start confluent-zookeeper",
      "sudo systemctl status confluent-zookeeper"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "sudo systemctl enable confluent-server",
      "sudo systemctl start confluent-server",
      "sudo systemctl status confluent-server"
    ]
  }
*/


  connection {
    host     = "192.168.56.10"
    type     = "ssh"
    user     = "root"
    password = "x"
    agent    = "false"
  }

}
