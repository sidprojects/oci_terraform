# Run $ source ./oci_env.sh to setup required ENV variables below:
# TF_VAR_tenancy_ocid, TF_VAR_user_ocid, TF_VAR_fingerprint
# TF_VAR_private_key_path

# Define OCI provider

provider "oci"{
    tenancy_ocid = var.tenancy_ocid
    user_ocid = var.user_ocid
    fingerprint = var.fingerprint
    region = var.region
    private_key_path = var.private_key_path
}

# Declare VCN config state
resource "oci_core_vcn" "t_vcn"{
    compartment_id = var.compartment_id
    cidr_blocks = var.vcn_cidr_blocks
    display_name = "Terraform VCN"
    dns_label = "tf"
    
    freeform_tags = var.tag
}

# Declare Internet gateweay config state 

resource "oci_core_internet_gateway" "t_ig"{
    vcn_id = oci_core_vcn.t_vcn.id
    compartment_id = var.compartment_id
    display_name = "Terraform IG"

    freeform_tags = var.tag
}

# Create a public subnet

resource "oci_core_subnet" "t_subnet"{
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.t_vcn.id
    cidr_block = var.subnet_cidr_block

    freeform_tags = var.tag
    display_name = "Public Subnet"
    security_list_ids = [
        oci_core_security_list.tcp_sec_list_80.id,
        oci_core_vcn.t_vcn.default_security_list_id
    ]
    route_table_id = oci_core_route_table.t_route_table.id

}

# Declare security lists to allow tcp traffic on 80, 22 ports.

resource "oci_core_security_list" "tcp_sec_list_80"{
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.t_vcn.id

    display_name = "Allow port 80 TCP traffic"
    freeform_tags = var.tag
    ingress_security_rules{
        protocol = var.tcp
        source = var.src
        source_type = "CIDR_BLOCK"
        stateless = "false"
        tcp_options {
          max = 80
          min = 80
        }

    }
}


# Declare routing table config to route outside traffic 0.0.0.0 to IG.

resource "oci_core_route_table" "t_route_table"{
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.t_vcn.id

    freeform_tags = var.tag
    display_name = "Terraform Route Table"
    route_rules {
        network_entity_id = oci_core_internet_gateway.t_ig.id

        destination = var.src
        destination_type = "CIDR_BLOCK"

    }
}


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
        # "user_data" = var.user_data
    }

}





output "webserver_pub_ip"{
    value = oci_core_instance.t_instance.public_ip
}

# output "username"{
#     value = oci_core_instance.t_instance.username
# }

variable "tenancy_ocid"{}
variable "user_ocid"{}
variable "fingerprint"{}
variable "region"{}
variable "private_key_path"{}

variable "ad"{
    default = 1
    description = "Availability Domain"
}
variable "compartment_id"{}
variable "vcn_cidr_blocks"{}

variable "subnet_cidr_block"{}

variable "tag" {}

variable "src" {}

variable "tcp" {}

variable "instance_shape" {}
variable "src_id" {}

variable "ssh_auth_key" {}

variable "icmp" {}

variable "user_data" {}