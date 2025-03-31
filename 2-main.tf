resource "aws_instance" "instance-1" {
    count = var.instance_count
    ami = var.ami_id
    #availability_zone = "us-east-1b"
    availability_zone = var.availability_zone
    instance_type = var.instance_type
    tags = {
       # "Name" = "Web-Instance"
       "Name" = "${var.env}-webserver-${count.index}"
    }
}