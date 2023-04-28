source "amazon-ebs" "ubuntu" {
  ami_name      = "${var.ami_prefix}-${local.timestamp}"
  instance_type = var.instance_type
  region        = var.region
  #ami_regions   = var.ami_regions
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
  tags         = var.tags
}

source "amazon-ebs" "redhat" {
  ami_name      = "packer-redhat-aws-{{timestamp}}"
  instance_type = var.instance_type
  region        = var.region
  source_ami_filter {
    filters = {
      name                = "RHEL-9.0.0_HVM-*_64-43-Hourly2-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["309956199498"]
  }

  ssh_username = "ec2-user"
  tags = {
    "Name"        = "MyRedhatImage"
    "Environment" = "Dev"
    "OS_Version"  = "RedHat"
    "Release"     = "Latest"
    "Created-by"  = "Packer"
  }
}

