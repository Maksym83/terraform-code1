data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws.sec.group.star]
  associate_public_ip_adresess = true
  availability_zone = "us-east-1"
  tags = local.common.tags
}
resource "aws_ebs_volume" "example"
availability_zone = "us-east-1"
size = 40
tags = local.common.tags
}
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id = aws_ebs_volume.example.id
  instance_id = aws_instance.web.id
}
  provisioner "remote-exec" {
    connections{
      host = aws_instance.web.public_ip
      type = "ssh"
      user = "centos"
      privet_key = file("~/.ssh/id_rsa")
    }
    inline = [
      "sudo apt-get install -y epel-relase -y",
      "sudo apt-get install httpd -y",
      "sudo systemctl start httpd",
      "sudosystemctl enable httpd" 
      ]
  }
  
      output "all"
  value = aws_instance.web*
  }
}
