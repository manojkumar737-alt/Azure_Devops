########################################
# Get Default VPC
########################################

data "aws_vpc" "default" {
  default = true
}

########################################
# Get Subnets from Default VPC
########################################

data "aws_subnets" "default" {

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

########################################
# Get Latest Ubuntu AMI Automatically
########################################

data "aws_ami" "ubuntu" {

  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

########################################
# Security Group
########################################

resource "aws_security_group" "prometheus_lab_sg" {

  name   = "prometheus-grafana-lab-sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
  description = "HTTP"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Grafana"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Prometheus"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Node Exporter"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Alertmanager"
    from_port   = 9093
    to_port     = 9093
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "prometheus-grafana-sg"
  }
}

########################################
# EC2 Instance
########################################

resource "aws_instance" "prometheus_lab" {

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id = "subnet-0bdd9ff541be12f66"
  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.prometheus_lab_sg.id
  ]

  root_block_device {

    volume_size = 10
    volume_type = "gp2"
  }

  user_data = file("install_monitoring.sh")

  tags = {
    Name = "prometheus-grafana-lab"
  }
}

########################################
# Output Public IP
########################################

output "instance_public_ip" {

  value = aws_instance.prometheus_lab.public_ip
}
