resource "null_resource" docker {

  /*provisioner "remote-exec" {
    inline = [
      "hostnamectl set-hostname master.art.local",
      "echo -e \"\n192.168.56.10 master.art.local master\n192.168.56.11 node1.art.local node1\n192.168.56.12 node2.art.local node2\" >> /etc/hosts"
    ]
  }*/

  provisioner "remote-exec" {

    inline = [
      "echo \"[TASK 1] Install docker container engine\"",
      "yum install -y -q yum-utils device-mapper-persistent-data lvm2",
      "yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo",
      "yum install -y -q docker-ce-19.03.5"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "echo \"[TASK 2] Enable and start docker service\"",
      "systemctl enable docker",
      "systemctl start docker"
    ]
  }
  provisioner "remote-exec" {
    inline = [
      "echo \"[TASK 3] Add yum repo file for kubernetes\"",
      "cat >>/etc/yum.repos.d/kubernetes.repo<<EOF\n[kubernetes]\nname=Kubernetes\nbaseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=0\ngpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg\nhttps://packages.cloud.google.com/yum/doc/rpm-package-key.gpg\nEOF"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "echo \"[TASK 4] Install Kubernetes (kubeadm, kubelet and kubectl)\"",
      "yum install -y -q kubeadm-1.17.1 kubelet-1.17.1 kubectl-1.17.1",
      "echo \"[TASK 5] Enable and start kubelet service\"",
      "systemctl enable kubelet",
      "echo 'KUBELET_EXTRA_ARGS=\"--fail-swap-on=false\"'",
      "systemctl start kubelet"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "echo \"[TASK 6] Install and configure ssh\"",
      "yum install -y -q openssh-server",
      "sed -i 's/.*PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config",
      "systemctl enable sshd",
      "systemctl start sshd"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "echo \"[TASK 7] Set root password\"",
      "echo \"kubeadmin\" | passwd --stdin root"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "echo \"[TASK 8] Install additional packages\"",
      "yum install -y -q which net-tools sudo sshpass less",
      "mknod /dev/kmsg c 1 1",
      "chmod +x /etc/rc.d/rc.local",
      "echo 'mknod /dev/kmsg c 1 11' >> /etc/rc.d/rc.local"
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