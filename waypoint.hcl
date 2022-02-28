app "test" {
  labels = {
  }

  build {
    use "docker" {}
  }

  deploy {
    use "docker" {}
  }
}