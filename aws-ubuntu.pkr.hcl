
source "amazon-ebs" "myfirstimage" {
  region     = "ap-south-1"
  source_ami = "ami-07ffb2f4d65357b42"
  instance_type = "t2.micro"
  ami_name   = "packer-ubuntu_{{timestamp}}"
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
  name    = "ubuntu-packer"
  sources = ["source.amazon-ebs.myfirstimage."]
}
