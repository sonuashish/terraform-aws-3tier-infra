output "vpc_id" {
  value = aws_vpc.myVPC.id
}

output "public_subnet_ids" {
  value = aws_subnet.Public_Subnet[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.Private_Subnet[*].id
}

output "security_group" {
  value = aws_security_group.main.id
}
