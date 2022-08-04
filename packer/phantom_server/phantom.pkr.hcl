
variable "general" {
    type = map(string)

    default = {
        attack_range_password = "Pl3ase-k1Ll-me:p"
        key_name = "attack-range-key-pair"
        attack_range_name = "ar"
        ip_whitelist = "0.0.0.0/0"
    }
}

variable "azure" {
    type = map(string)

    default = {
        location = "West Europe"
        private_key_path = "~/.ssh/id_rsa"
        public_key_path = "~/.ssh/id_rsa.pub"
    }
}

variable "aws" {
    type = map(string)

    default = {
        region = "eu-central-1"
        private_key_path = "~/.ssh/id_rsa"
        image_owner = "591511147606"
    }
}

variable "phantom_server" {
    type = map(string)
    default = {
        phantom_server = "0"
        phantom_community_username = "user"
        phantom_community_password = "password"
        phantom_repo_url = "https://repo.phantom.us/phantom/5.2/base/7/x86_64/phantom_repo-5.2.1.78411-1.x86_64.rpm"
        phantom_version = "5.2.1.78411-1"
    }
}

variable "splunk_server" {
    type = map(string)

    default = {
        install_es = "0"
        splunk_es_app = "splunk-enterprise-security_701.spl"
    }
}

data "amazon-ami" "centos-ami" {
  filters = {
    name                = "CentOS-7-2111-20220330_2.x86_64*"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  most_recent = true
  owners      = ["679593333241"]
}

source "amazon-ebs" "phantom" {
  ami_name              = "phantom-v${replace(var.general.version, ".", "-")}"
  region = var.aws.region
  instance_type         = "t3.2xlarge"
  launch_block_device_mappings {
    device_name = "/dev/sda1"
    volume_size = "20"
  }
  source_ami   = "${data.amazon-ami.centos-ami.id}"
  ssh_username = "centos"
  force_deregister = true
  force_delete_snapshot = true
}

source "azure-arm" "phantom" {
  managed_image_resource_group_name = "packer_${replace(var.azure.location, " ", "_")}"
  managed_image_name = "phantom-v${replace(var.general.version, ".", "-")}"
  os_type = "Linux"
  image_publisher = "openlogic"
  image_offer = "centos"
  image_sku = "7_9"
  location = var.azure.location
  vm_size = "Standard_A8_v2"
  use_azure_cli_auth = true
}

build {

  sources = [
    "source.azure-arm.phantom",
    "source.amazon-ebs.phantom"
  ]

  provisioner "ansible" {
    extra_arguments = ["--extra-vars", "${join(" ", [for key, value in var.splunk_server : "${key}=\"${value}\""])} ${join(" ", [for key, value in var.phantom_server : "${key}=\"${value}\""])}"]
    playbook_file   = "packer/ansible/phantom_server.yml"
  }

}