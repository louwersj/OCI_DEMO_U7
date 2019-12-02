# Create a virtual cloud network within the newly created compartment for this
# specific deployment. This is the deployment_core_compartment. We do refer to
# this VCN as the deployment_core_vcn. DO NOTE; take a look at the CIDR block


resource "oci_core_virtual_network" "deployment_core_vcn" {
  compartment_id = "${oci_identity_compartment.deployment_root_compartment.id}"
  display_name = "Core VCN ${var.deployment_id}"
  cidr_block = "192.168.11.0/24"
  dns_label = "core${var.deployment_id}"
}
