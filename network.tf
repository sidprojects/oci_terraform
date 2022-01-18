
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
