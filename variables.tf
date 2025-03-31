variable "instance_count" {
    description = "How many instances are needed"
    type = number
    #default = 2
}

variable "availability_zone" {
  description = "AZ my vm should be created"
  type = string
  #default = "us-east-1a"
}

variable "instance_type" {
  type =  string
  #default = "t2.micro"
}

variable "ami_id" {
  type = string
  #default = "ami-08b5b3a93ed654d19"
}

variable "env" {
  type = string
}