## VMware login details
vsphere_server             = "smx-vcenter.cisco.com" 
vsphere_user               = "localhost\\cloudinfra1"
vsphere_password           = "cloudinfra1"
vsphere_ssl_skip           = "true"

vsphere_template           = "templates/Centos7_Vm"
vsphere_datacenter         = "CloudInfra"
vsphere_cluster            = ""
vsphere_vcpu               = 2
vsphere_memory             = 4096
vsphere_label1             = "PortGroup-2000"
vsphere_datastore          = "ci-ds/datastore2"

## Deployed VM login privilege
centos_user                = "root"
centos_password            = "cisco123"

