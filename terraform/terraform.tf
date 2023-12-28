provider "aws" {
  region = "us-east-1"    
}

resource "aws_dynamodb_table" "tf_note_table" {
  name = format("%s_%s",var.dynamodb_table_name , terraform.workspace!="" ? terraform.workspace : "")
  billing_mode = "PROVISIONED"
  read_capacity = lookup(var.provisioned_read_capacity,terraform.workspace,1)
  write_capacity = lookup(var.provisioned_write_capacity,terraform.workspace,1)
  hash_key = "user_id"
  range_key = "timestamp"
  attribute {
    name = "user_id"
    type = "S"    
  }
  attribute {
    name = "timestamp"
    type = "N"
  }

  attribute {
    name = "note_id"
    type = "S"
  }

    global_secondary_index {
      name = format("%s_%s_%s",var.dynamodb_table_name, terraform.workspace!="" ? terraform.workspace : "" ,"index")
      hash_key = "note_id"
      projection_type = "ALL"
      read_capacity = lookup(var.provisioned_read_capacity,terraform.workspace,1)
      write_capacity = lookup(var.provisioned_write_capacity,terraform.workspace,1)
    }

    tags = {
    Name        = "dynamodb-table-001"
    Environment = terraform.workspace
  }

}
