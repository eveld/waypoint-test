project = "test"

app "infra" {
  build {
    use "terraform" {
      // version = "v1.1.5"

      backend {
        // type         = "cloud"
        // organization = "a-demo-organization"
        // workspace    = "hashiconf-waypoint"

        type    = "consul"
        address = "localhost:8500"
        scheme  = "http"
        path    = "terraform/state"
      }

      module {
        name    = "cidr"
        source  = "hashicorp/subnets/cidr"
        version = "1.0.0"

        inputs = <<-EOF
          base_cidr_block = "10.0.0.0/8"
          networks = [
            {
              name     = "bar"
              new_bits = 8
            }
          ]
        EOF

        // outputs = {
        //   network_name = module.second.networks[0].name
        // }
      }
    }
  }

  deploy {
    use "terraform" {
      // version = "v1.1.5"

      backend {
        // type         = "cloud"
        // organization = "a-demo-organization"
        // workspace    = "hashiconf-waypoint"

        type    = "consul"
        address = "localhost:8500"
        scheme  = "http"
        path    = "terraform/state"
      }

      module {
        name    = "cidr"
        source  = "hashicorp/subnets/cidr"
        version = "1.0.0"

        inputs = <<-EOF
          base_cidr_block = "10.0.0.0/8"
          networks = [
            {
              name     = "bar"
              new_bits = 8
            }
          ]
        EOF

        // outputs = {
        //   network_name = module.second.networks[0].name
        // }
      }
    }
  }

  release {
    use "noop" {}
  }
}