output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_01.id
}

output "public_subnet1_id" {
  value = aws_subnet.public_02.id
}
