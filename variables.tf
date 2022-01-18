variable "ad"{
    default = 1
    description = "Availability Domain"
}


variable "tenancy_ocid"{}
variable "user_ocid"{}
variable "fingerprint"{}
variable "region"{}
variable "private_key_path"{}


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