variable "ad"{
    default = 1
    description = "Availability Domain"
}


variable "tenancy_ocid"{
    description = "Your tenancy OCID from OCI profile, set as env variable TF_VAR_tenancy_ocid"
}
variable "user_ocid"{
    description = "User OCID from OCI, set as env variable TF_VAR_user_ocid"
}
variable "fingerprint"{
    description = "Fingerprint from API key created OCI user details"
}
variable "region"{
    description = "Set in tfvars file, region you want your resources in"
}
variable "private_key_path"{
    description = "Set in env variable TF_VAR_private_key_path, local path to ssh private key"
}

variable "compartment_id"{
    description = "Set in env variable TF_VAR_compartment_id, compartment OCID"
}
variable "vcn_cidr_blocks"{
    description = "CIDR blocks for your VCN"
}

variable "subnet_cidr_block"{
    description = "CIDR block for your subnet"
}

variable "tag" {
    description = "Default tag"
}

variable "src" {
    description = "CIDR blocks of incoming IP addresses"
}

variable "tcp" {
    description = "TCP protocol ID, refer OCI docs for details"
}

variable "instance_shape" {
    description = "Compute shape of your choice"
}
variable "src_id" {
    description = "OS image OCID"
}

variable "ssh_auth_key" {
    description = "SSH public key to pass to VM instance"
}

variable "user_data" {
    description = "Shell script base64 encoded, set in tfvars, decode to get the script"
}