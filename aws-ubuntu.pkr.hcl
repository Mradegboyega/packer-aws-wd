packer {
  required_plugins {
    amazon = {
      version = ">= 1.3.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

locals {
  timestamp = formatdate("YYYY-MM", timestamp())
}

source "amazon-ebs" "ubuntu" {

    ami_name      = "my-ami-${local.timestamp}"
    instance_type = "t2.micro"
    region        = "eu-west-2"
    source_ami = "ami-0d18e50ca22537278"
    ssh_username = "ubuntu"
    // aws_access_key = var.AWS_ACCESS_KEY
    // aws_secret_key = var.AWS_SECRET_KEY
    source_ami_filter {
        filters = {
        name                = "ubuntu/images/*ubuntu-jammy-22.04-amd64-server-*"
        root-device-type    = "ebs"
        virtualization-type = "hvm"
        }
        most_recent = true
        owners      = ["099720109477"]
    }
}

build {
  name = "my-first-build"
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    environment_vars = [
      "user=adegboyega",
    ]
    inline = [
      "echo Installing Redis",
      "sleep 30",
      "sudo apt-get update",
      "sudo apt-get install nginx -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "sudo apt-get install -y redis-server",
      "sudo apt-get install ufw",
      "sudo ufw allow proto tcp from any to any port 22,80,443",
      "sudo ufw allow 'Nginx Full'",
      "sudo ufw allow OpenSSH",
      "echo 'y' | sudo ufw enable",
      "echo \"You are the root user, $user\" > user.txt"
    ]
  }
}

