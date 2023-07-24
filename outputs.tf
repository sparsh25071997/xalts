output "publicip" {
    value = aws_instance.apihitserver.public_ip
    description = "public ip address"
}