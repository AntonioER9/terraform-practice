resource "aws_instance" "public_instance" {
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = file("scripts/userdata.sh")


  provisioner "local-exec" {
    command = "echo instance public_ip is ${self.public_ip} >> public_instance_ip.txt"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo instance public_ip is ${self.public_ip} destroyed >> public_instance_ip_destroy.txt"
  }

  # provisioner "remote-exec" { //En la vida real esto no se usa.
  #   inline = [
  #     "echo 'Hello, World' > ~/hello.txt",
  #   ]

  #   connection {
  #     type        = "ssh"
  #     host        = self.public_ip
  #     user        = "ec2-user"
  #     private_key = file("mykey.pem")
  #   }

  # }

  # lifecycle {
  #   # create_before_destroy = true
  #   # prevent_destroy = true
  #   # ignore_changes = [ 
  #   #   ami
  #   #  ]
  #   replace_triggered_by = [ 
  #     aws_subnet.private_subnet 
  #   ] # Si sufre un cambio, la subnet privada, vamos a destruir y construir nuevamente la instancia.
  # }
}
