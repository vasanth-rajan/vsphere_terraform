variable label { }
variable cpu   { }

provider "vsphere" {
  vsphere_server       = "smx-vcenter.cisco.com"
  allow_unverified_ssl = "true"
}

resource "vsphere_virtual_machine" "nodes" {
   datacenter          = "CloudInfra"
   cluster             = ""
   vcpu                = "${var.cpu}"
   memory              = 512
   disk {
       datastore       = "ci-ds/datastore2"
       template        = "templates/testTemplate"
       type            = "thin"
   }
   network_interface {
       label           = "${var.label}"
     } 

  lifecycle { create_before_destroy = true }
 
  name    = "${format("vasanthTestVm2-%03d", count.index + 1)}"
  folder  = "VmInstances"

}
