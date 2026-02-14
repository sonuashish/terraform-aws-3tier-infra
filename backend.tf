terraform {
  backend "s3" {
    bucket               = "terraform-state-list-snapshots"
    key                  = "infra/terraform.tfstate"
    region               = "ap-south-1"
    dynamodb_table       = "terraform-state-file-dynamodb-table"
    workspace_key_prefix = "env"
  }
}
