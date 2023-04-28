build {
  name        = "ubuntu"
  description = <<EOF
This build creates linux images for ubuntu and RH versions :
For the following builers :
* amazon-ebs
EOF
  sources = [
    "source.amazon-ebs.ubuntu",
    "source.amazon-ebs.redhat"
  ]


  provisioner "shell" {
    only = ["source.amazon-ebs.ubuntu"]
    inline = ["sudo apt-get install awscli",
      "sudo apt-get update -y",
      "sudo apt install nginx -y",
      "sudo systemctl start nginx"
    ]
  }

  provisioner "shell" {
    only = ["source.amazon-ebs.redhat"]
    inline = ["sudo yum update -y",
      "sudo yum install nginx -y",
    "sudo systemctl start nginx"]
  }

  post-processor "manifest" {}

}