resource "aws_instance" "monolith" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name    = "EC2-${local.service_name}"
    Service = local.service_name
  }

  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]
  subnet_id              = aws_subnet.public_subnet_monolith.id
}
