
variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "amis_regions" {
  type    = list(string)
  default = ["ap-south-1", "us-east-1"]
}

source "amazon-ebs" "multi-region-ami-redhat" {
  region        = var.region
  instance_type = "t2.micro"
  source_ami    = "ami-0fdea1353c525c182"
  ami_name      = "packer_AWS_example_{{timestamp}}"
  ami_regions   = var.amis_regions
  ssh_username  = "ec2-user"
  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = "*RHEL-9.0.0_HVM-*-x86_64-43-*-GP2"
      root-device-type    = "ebs"
    }
    owners      = ["309956199498"]
    most_recent = true
  }
}

build {
  sources = [
    "source.amazon-ebs.multi-region-ami-redhat"
  ]
}
