
terraform {
	required_providers {}
	backend "consul" {
    address = "localhost:8500"
    scheme  = "http"
    path    = "terraform/state"
  }
}
module "cidr" {
	source = "hashicorp/subnets/cidr"
	version = "1.0.0"

	base_cidr_block = "10.0.0.0/8"
networks = [
  {
    name     = "bar"
    new_bits = 8
  }
]

}
output "cidr" {
	value = module.cidr
}
