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

resource "null_resource" "server" {
  provisioner "local-exec" {
    command = "D:/kafka_2.13-2.6.0/bin/windows/zookeeper-server-start.bat D:/kafka_2.13-2.6.0/config/zookeeper.properties"
    interpreter = ["PowerShell", "-Command"]
  }
}
resource "null_resource" "node1" {
  provisioner "local-exec" {
    command = "D:/kafka_2.13-2.6.0/bin/windows/kafka-server-start.bat D:/kafka_2.13-2.6.0/config/server-1.properties"
    interpreter = ["PowerShell", "-Command"]
  }
}
resource "null_resource" "node2" {
  provisioner "local-exec" {
    command = "D:/kafka_2.13-2.6.0/bin/windows/kafka-server-start.bat D:/kafka_2.13-2.6.0/config/server-2.properties"
    interpreter = ["PowerShell", "-Command"]
  }
}