# Create the top level compartment under the root compartment for the
# deployment of all other resources. Within Terraform we refer to this
# as the deployment_root_compartment. DO NOTE: this is not the root
# compartment of the acutal tenancy. We do use the deployement_id as 
# an identifyer and name for the new compartment. 


resource "oci_identity_compartment" "deployment_root_compartment" {
    compartment_id = "${var.compartment_ocid}"
    description = "Compartment ${var.deployment_id}"
    name = "${var.deployment_id}"
}
