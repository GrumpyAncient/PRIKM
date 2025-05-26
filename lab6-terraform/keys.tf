resource "aws_key_pair" "deployer" {
  key_name   = "lab6-key"
  public_key = file("~/.ssh/id_rsa.pub")
}
