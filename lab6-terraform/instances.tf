resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = tolist(values(aws_subnet.public))[0].id
  vpc_security_group_ids = [aws_security_group.ssh_http.id]
  key_name               = aws_key_pair.deployer.key_name
  user_data              = templatefile("userdata.tpl", {})

  tags = { Name = "lab6-web-server" }
}
