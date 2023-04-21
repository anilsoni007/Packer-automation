
variable "amis_regions" {
  type    = list(string)
  default = ["ap-south-1", "us-east-1"]
}

source "amazon-ebs" "multi_image" {
  region           = "ap-south-1"
  source_ami       = "ami-07ffb2f4d65357b42"
  instance_type    = "t2.micro"
  ami_name         = "packer-ubuntu.{{timestamp}}"
  ami_regions = var.amis_regions
  force_deregister = true
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*/ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
  

}

build {
  name    = "multi-region-AMI"
  sources = ["source.amazon-ebs.multi_image.var.amis_regions[0]", "source.amazon-ebs.multi_image.var.amis_regions[1]"]
}
