variable "master_node_ip" {
  type = string
  default = "192.168.56.10"
  description = ""
}


resource "null_resource" java_install {


  // install helm
  provisioner "remote-exec" {
    inline = [
      "wget https://get.helm.sh/helm-v3.4.1-linux-amd64.tar.gz",
      "tar -xzf helm-v3.4.1-linux-amd64.tar.gz",
      "mv linux-amd64/helm /usr/local/bin/helm",
    ]
  }
/*

  // install prometheus
  provisioner "remote-exec" {
    inline = [
      "helm repo add prometheus-community https://prometheus-community.github.io/helm-charts",
      "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml",
      "helm install prometheus prometheus-community/prometheus",
      "kubectl expose service prometheus-server --type=NodePort --target-port=9090 --name=prometheus-server-svc",
      // get the port
      // kubectl get svc prometheus-server-svc
      // http://192.168.56.10:30947
    ]
  }

  // install gafana
  provisioner "remote-exec" {
    inline = [
      "helm repo add grafana https://grafana.github.io/helm-charts",
      "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml",
      "helm install grafana grafana/grafana",
      "kubectl expose service grafana --type=NodePort --target-port=3000 --name=grafana-svc",
      // get the port
      // kubectl get svc grafana-svc
      // http://192.168.56.10:31214
      // get admin password
      "kubectl get secret --namespace default grafana -o jsonpath=\"{.data.admin-password}\" | base64 --decode ; echo"
      // UI http://192.168.56.10:31214/datasources -> "Add data source" -> "Prometheus" -> "URL" = http://192.168.56.10:30947
      // UI http://192.168.56.10:31214/dashboard/import -> "Create" -> "Import" -> "6417" -> "Select Prometheus data source"
    ]
  }
*/

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
