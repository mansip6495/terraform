
resource "aws_vpc" "webapp" {
    cidr_block = "${var.vpc_cidr}"
}

resource "aws_internet_gateway" "webapp" {
    vpc_id = "${aws_vpc.webapp.id}"
}

resource "aws_subnet" "webapp_public" {
  vpc_id     = "${aws_vpc.webapp.id}"
  cidr_block = "${var.public_subnet_cidr}"

}

resource "aws_route_table" "us-east-1-public" {
    vpc_id = "${aws_vpc.webapp.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.webapp.id}"
    }

}

resource "aws_route_table_association" "us-east-1-public" {
    subnet_id = "${aws_subnet.webapp_public.id}"
    route_table_id = "${aws_route_table.us-east-1-public.id}"
}

resource "aws_security_group" "instance" {
    description = "Allow ssh access"
    ingress {
    	from_port   = 22
    	to_port     = 22
   	protocol    = "tcp"
    	cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.webapp.id}"

}

resource "aws_instance" "web" {
  ami           = "${lookup(var.AMI, "us-east-1")}"
  instance_type = "t2.micro"
  key_name = "mansi"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
  subnet_id = "${aws_subnet.webapp_public.id}"	
  associate_public_ip_address=true
  tags = {
    Owner = "Mansi"
  }
}

