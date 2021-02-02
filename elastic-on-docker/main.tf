variable "master_node_ip" {
  type = string
  default = "192.168.56.13"
  description = ""
}


resource "null_resource" elastic_docker_install {


  provisioner "file" {
    source      = "docker-compose.yml"
    destination = "docker-compose.yml"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p pipeline",
    ]
  }

  provisioner "file" {
    source      = "logstash.conf"
    destination = "pipeline/logstash.conf"
  }

  provisioner "remote-exec" {
    inline = [
      "docker-compose up -d",
      "docker ps",
      "echo \"elasticsearch:\"",
      "echo \"http://${var.master_node_ip}:9200/_cat/nodes?v&pretty\"",
      "echo \"kibana:\"",
      "echo \"http://${var.master_node_ip}:5601\"",
      "echo \"logstash:\"",
      "echo \"http://${var.master_node_ip}:5009\"",
    ]
  }

//  docker-compose stop logstash
//  docker-compose start logstash
//  docker-compose logs -f logstash

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
