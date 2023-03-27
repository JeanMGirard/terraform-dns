

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.22"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.22"
    }
  }
}

