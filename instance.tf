resource "aws_key_pair" "raja-key" {
  key_name   = "rajakey"
  public_key = file(var.PUB_KEY)
}

resource "aws_instance" "raja-web" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.raja-pub-1.id
  key_name               = aws_key_pair.raja-key.key_name
  vpc_security_group_ids = [aws_security_group.raja_stack_sg.id]
  tags = {
    Name = "my-raja"
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  provisioner "remote-exec" {

    inline = [
      "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }

  connection {
    user        = var.USER
    private_key = file("rajakey")
    host        = self.public_ip
  }
}

output "PublicIP" {
  value = aws_instance.raja-web.public_ip
}
