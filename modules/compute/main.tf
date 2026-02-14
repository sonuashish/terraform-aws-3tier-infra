resource "aws_instance" "ec2" {

  ami           = "ami-0317b0f0a0144b137"
  key_name      = "my-server-key-pair"
  count         = length(var.instance_type)
  instance_type = var.instance_type[count.index]

  subnet_id = count.index == 0 ? var.public_subnet_id : var.private_subnet_ids[count.index - 1]

  associate_public_ip_address = count.index == 0 ? true : false

  vpc_security_group_ids = [var.security_group]

  tags = {
    Name = "${var.env}-${var.instance_name[count.index]}"
  }
}




resource "aws_ebs_volume" "extra_volume" {
  count             = length(aws_instance.ec2)
  availability_zone = aws_instance.ec2[count.index].availability_zone
  size              = 8
  type              = "gp3"

  tags = {
    Name = "${var.env}-${var.instance_name[count.index]}-volume"
  }
}


resource "aws_volume_attachment" "attach_volume" {
  count = length(aws_instance.ec2)

  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.extra_volume[count.index].id
  instance_id = aws_instance.ec2[count.index].id
}

