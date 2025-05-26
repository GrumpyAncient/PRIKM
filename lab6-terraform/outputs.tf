output "public_ip" {
  description = "Public IP of web server"
  value       = aws_instance.web.public_ip
}

output "web_url" {
  description = "Access URL"
  value       = "http://${aws_instance.web.public_ip}"
}
