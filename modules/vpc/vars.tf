varible "cidr" {
   type=number
   cidr = ["23.0.0.0/16"]
}
variable "tena" {
 default=default
}
variable "subnetrange" {
  default=["23.0.1.0/24"]
}
variable "tagname"{
  default=wipro-client
}
varibale "vpc-id"{
   default= aws_vpc.wipro.id
}
variable "igw" {
 default=aws_internet_gateway.internet-access.id
}
