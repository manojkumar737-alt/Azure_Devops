output "public_ip" {

  value = aws_instance.prometheus_lab.public_ip
}
output "grafana_url" {

  value = "http://${aws_instance.prometheus_lab.public_ip}:3000"
}

output "prometheus_url" {

  value = "http://${aws_instance.prometheus_lab.public_ip}:9090"
}

output "node_exporter_url" {

  value = "http://${aws_instance.prometheus_lab.public_ip}:9100"
}