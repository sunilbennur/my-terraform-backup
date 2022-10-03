resource "aws_instance" "ubntu_server" {
  ami                    = "ami-02ea247e531eb3ce6"
  instance_type          = var.instance_type
  count                  = var.instance_count
  key_name               = "keypairec2"
  vpc_security_group_ids = [aws_security_group.main.id]

  tags = {
    Name = "terraform-ec2"
  }

  user_data = "${file("script.sh")}"

}

resource "aws_security_group" "main" {
  name = "main"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_key_pair" "deployer" {
  key_name   = "keypairec2"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDf6xsNV05laLiSmw+cEfLGUcuwJSU88DPZcG25s9hTcFNxEYhb/mi1uTf6ktvWM/uyLtNLbsMuENx/7wSvhCdg+SJIeSK7j0O05QMy0xR/2yZALGpTUo885eZCNtMfdNqA/dbrCa2qdN1AP8PhxB+mbMrsID66DOVcSTqvMkSn/jhymHrYS1FDLBcldXJpy2yONZNh3escShx60fC/Jy2p39PJQUUyX0Sol5oz6KIgRf861BFuui2IUVjkC/OVc1nrt5nlZaTtv853PCG+6d22nkjBGThSdL1neN/111okS9CoR5WTB6Si/po3TdnQkTs5KNRE9HmScBP31wtQ+BuT sunil@sriram"
}
