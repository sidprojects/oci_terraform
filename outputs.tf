output "webserver_pub_ip"{
    value = oci_core_instance.t_instance.public_ip
}