provider "vsphere" {
  user                 = "localhost\\cloudinfra1"
  password             = "cloudinfra1"
  vsphere_server       = "smx-vcenter.cisco.com"
  allow_unverified_ssl = "true"
}

resource "vsphere_virtual_machine" "nodes" {
   datacenter          = "CloudInfra"
   cluster             = ""
   vcpu                = 1
   memory              = 512
   disk {
       datastore       = "ci-ds/datastore2"
       template        = "templates/testTemplate"
       type            = "thin"
   }
   network_interface {
       label           = "PortGroup-2000"
     } 

  lifecycle { create_before_destroy = true }
 
  name    = "${format("vasanthTestVm-%03d", count.index + 1)}"
  folder  = "VmInstances"

}
