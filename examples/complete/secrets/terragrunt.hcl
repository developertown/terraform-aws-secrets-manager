include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../..//."
}

inputs = {
  enabled = true

  region      = "us-east-2"
  environment = "test"
  name        = "example"

  secret_version = {
    secret_string = jsonencode(
      {
        ssh_public_key  = "ssh-rsa AAAAB3NzaC1yc2"
        ssh_private_key = "private key"
      }
    )
  }

  kms_key = {
    enabled = false
  }

  tags = {
    "Company" = "DeveloperTown"
  }
}
