# Run $ source ./oci_env.sh to setup required ENV variables
region = "ap-seoul-1"
vcn_cidr_blocks = ["10.0.0.0/16", "10.1.0.0/16"]
subnet_cidr_block = "10.0.1.0/24"
tag = {
     "Purpose" : "Testing Terraform" 
}

src = "0.0.0.0/0"
tcp = "6"

ad = "tOuk:AP-SEOUL-1-AD-1"

instance_shape = "VM.Standard.E2.1.Micro"
src_id = "ocid1.image.oc1.ap-seoul-1.aaaaaaaapqkj57pmhwsmm6medm37vg2jny4v73lw426qszfdzkq7wkzcqgaq"

user_data = "IyEvdXNyL2Jpbi9zaApzdWRvIGFwdCB1cGRhdGUKc3VkbyBhcHQgLXkgaW5zdGFsbCBhcGFjaGUyCnN1ZG8gc3lzdGVtY3RsIHJlc3RhcnQgYXBhY2hlMgpzdWRvIGlwdGFibGVzIC1JIElOUFVUIDYgLW0gc3RhdGUgLS1zdGF0ZSBORVcgLXAgdGNwIC0tZHBvcnQgODAgLWogQUNDRVBUCnN1ZG8gbmV0ZmlsdGVyLXBlcnNpc3RlbnQgc2F2ZQpzdWRvIHN1CmVjaG8gIldlbGNvbWUgdG8gbXkgd2Vic2VydmVyIiA+IC92YXIvd3d3L2h0bWwvaW5kZXguaHRtbApleGl0"





