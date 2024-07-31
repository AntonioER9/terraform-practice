resource "aws_instance" "public_instance" {
  ami           = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = data.aws_key_pair.key.key_name

  lifecycle {
    # create_before_destroy = true
    # prevent_destroy = true
    # ignore_changes = [ 
    #   ami
    #  ]
    replace_triggered_by = [ aws_subnet.private_subnet ] # Si sufre un cambio, la subnet privada, vamos a destruir y construir nuevamente la instancia.
  }
}
