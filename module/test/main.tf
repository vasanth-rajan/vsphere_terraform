variable "vsphere_server" { }
variable "vsphere_ssl_skip" { }

variable "vsphere_datacenter" { }
variable "vsphere_cluster" { }
variable "vsphere_vcpu" { }
variable "vsphere_memory" { }
variable "vsphere_datastore" { }
variable "vsphere_template" { }
variable "vsphere_label1" { }
variable "centos_user" { }
variable "centos_password" { }


provider "vsphere" {
  vsphere_server       = "${var.vsphere_server}"
  allow_unverified_ssl = "${var.vsphere_ssl_skip}"
}

resource "vsphere_virtual_machine" "nodes" {
   datacenter          = "${var.vsphere_datacenter}"
   cluster             = "${var.vsphere_cluster}"
   vcpu                = "${var.vsphere_vcpu}"
   memory              = "${var.vsphere_memory}"
   disk {
       datastore       = "${var.vsphere_datastore}"
       template        = "${var.vsphere_template}"
   }
   network_interface {
       label           = "${var.vsphere_label1}"
     } 

  lifecycle { create_before_destroy = true }
 
  name    = "${format("testVM-%03d", count.index + 2)}"
  folder  = "VmInstances"
 
  
  provisioner "file" {
    source = "/home/centos/ces_work/openssh-ansible/rpmbuild/RPMS/noarch/openssh-ansible-1-1.noarch.rpm"
    destination = "/home/centos/openssh-ansible-1-1.noarch.rpm"
        connection {
          user = "${var.centos_user}"
          password = "${var.centos_password}"
        }
  }

 
  provisioner "remote-exec" {
        inline = [
        "rpm -Uvh /home/centos/openssh-ansible-1-1.noarch.rpm",
        "ansible-playbook /usr/local/playbooks/openssh-ansible/site.yml -i /usr/local/playbooks/openssh-ansible/hosts -e 'operation=install' --connection=local"
        ]
        connection {
          user = "${var.centos_user}"
          password = "${var.centos_password}"
        }
    }
}

output "private_ips" { value = "${vsphere_virtual_machine.nodes.network_interface.0.ipv4_address}" }

