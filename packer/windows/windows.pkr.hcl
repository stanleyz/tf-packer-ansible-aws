source "amazon-ebs" "windows" {
  ami_name      = "windows-${var.windows_version}-{{timestamp}}"
  instance_type = var.instance_type
  region        = var.region
  source_ami_filter {
    filters = {
      name = "Windows_Server-${var.windows_version}.*"
    }
    owners      = var.ami_owners
    most_recent = true
  }
  ssh_username    = "packeradmin"
  ami_description = "Windows Server ${var.windows_version} with some packages pre-built in"
}

build {
  sources = ["source.amazon-ebs.windows"]

  provisioner "ansible" {
    playbook_file   = "ansible/playbook.yml"
    extra_arguments = ["-e", "ansible_connection=ssh"]
  }
}
