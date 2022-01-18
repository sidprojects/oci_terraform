# Declare compute instance state.
#   Create the following inside the instance:
#       1. Install webserver
#       2. Capture public IP, username

resource "oci_core_instance" "t_instance"{
    availability_domain = var.ad
    compartment_id = var.compartment_id
    shape = var.instance_shape

    create_vnic_details {
      subnet_id = oci_core_subnet.t_subnet.id
      assign_public_ip = "true"
      assign_private_dns_record = "true"
    }

    display_name = "Ubuntu VM"
    freeform_tags = var.tag

    source_details {
		source_id = var.src_id
		source_type = "image"
	}
    metadata = {
        "ssh_authorized_keys" = var.ssh_auth_key
        "user_data" = var.user_data
    }

}

