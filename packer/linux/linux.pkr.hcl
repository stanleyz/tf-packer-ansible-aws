# Define the builder for Amazon EC2
source "amazon-ebs" "linux" {
  ami_name      = "${var.distribution}-${var.distribution_version}-{{timestamp}}"
  instance_type = var.instance_type
  region        = var.region
  source_ami_filter {
    filters = {
      name = "${var.distribution}*${var.distribution_version}*${var.ami_architecture}*"
    }
    owners      = var.ami_owners
    most_recent = true
  }
  ssh_username    = var.ssh_username
  ami_description = "${var.distribution} ${var.distribution_version} with certain packages pre-built in"
}

# Provisioners to install Nginx and configure SSL
build {
  sources = ["source.amazon-ebs.linux"]

  provisioner "shell" {
    scripts = [
      "./scripts/pre-build.sh",
      "./scripts/install-nginx.sh",
    ]
    env = {
      BUILD_FILES_REMOTE_PATH = local.build_files_remote_path
    }
  }

  provisioner "file" {
    source      = "./files"
    destination = local.build_files_remote_path
  }

  provisioner "ansible-local" {
    playbook_file = "ansible/playbook.yml"
    extra_arguments = [
      "--extra-vars",
      "\"build_files_remote_path=${local.build_files_remote_path}\"",
    ]
  }

  provisioner "shell" {
    script = "./scripts/post-build.sh"
    env = {
      BUILD_FILES_REMOTE_PATH = local.build_files_remote_path
    }
  }
}
