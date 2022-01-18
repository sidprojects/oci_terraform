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
