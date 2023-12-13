terraform {
    source = "../../../../modules//vm-module/"
}


inputs = {
    name = "example-2-terragrunt-terraform-vm-module"
    target_node = "ibm-x3200-prox2"
    clone_template = "debian11-cloudinit-template-node2"
    ciuser = "debian"
}