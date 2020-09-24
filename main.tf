
terraform {
    /*
    backend "remote" {
        hostname     = "app.terraform.io"
        organization = "noct-cloud"

        workspaces {
        name = "noct-cloud"
        }
    }
    */
    required_providers {
        civo = {
        source  = "civo/civo"
        version = "0.9.17"
        }
        tls = {
        source = "hashicorp/tls"
        version = "2.2.0"
        }    
    }
}

variable "civo_token" {
  type = string
}

provider "civo" {
  token = var.civo_token
}

resource "civo_network" "custom_net" {
    label = "test_network"
}

data "civo_template" "ubuntu" {
   filter {
        key = "code"
        values = ["ubuntu-18.04"]
   }
}

data "civo_instances_size" "node_size" {
  filter {
    key    = "name"
    values = ["g2.small"]
  }
}

resource "tls_private_key" "test_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "civo_ssh_key" "civo_bastion_key" {
    name = "bastion-test-key"
    public_key = tls_private_key.test_key.public_key_openssh
}

resource "civo_instance" "foo" {
    hostname = "foo"
    size = element(data.civo_instances_size.node_size.sizes, 0).name
    template = element(data.civo_template.ubuntu.templates, 0).id
    sshkey_id = civo_ssh_key.civo_bastion_key.id
    network_id = civo_network.custom_net.id
}


resource "civo_instance" "bar" {
    hostname = "bar"
    size = element(data.civo_instances_size.node_size.sizes, 0).name
    template = element(data.civo_template.ubuntu.templates, 0).id
    sshkey_id = civo_ssh_key.civo_bastion_key.id
    network_id = civo_network.custom_net.id
}

resource null_resource test {
  
  connection {
      timeout = "120s"
      type = "ssh"
      host = civo_instance.foo.public_ip
      user = civo_instance.foo.initial_user
      private_key = tls_private_key.test_key.private_key_pem
  }

  provisioner "remote-exec" {
    inline  = [
      "ping ${civo_instance.bar.private_ip}"
      ]
  }

}