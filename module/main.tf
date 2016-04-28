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

module "test" {
  source = "./test"  
 
  vsphere_server        = "${var.vsphere_server}"
  vsphere_ssl_skip      = "${var.vsphere_ssl_skip}"
  vsphere_datacenter    = "${var.vsphere_datacenter}"
  vsphere_cluster       = "${var.vsphere_cluster}"
  vsphere_vcpu          = "${var.vsphere_vcpu}"
  vsphere_memory        = "${var.vsphere_memory}"
  vsphere_datastore     = "${var.vsphere_datastore}"
  vsphere_template      = "${var.vsphere_template}"
  vsphere_label1        = "${var.vsphere_label1}"
  centos_user           = "${var.centos_user}"
  centos_password       = "${var.centos_password}"
}

output "private_ips" { value = "${module.test.private_ips}" }

