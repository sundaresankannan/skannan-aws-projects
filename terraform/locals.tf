variable "dynamodb_table_name" {
  type = string
  default = "user_notes"
}

variable "provisioned_read_capacity" {
  type = map(number)
  default = {
    "dev" = 1
    "prod" = 5
  }
}

variable "provisioned_write_capacity" {
  type = map(number)
  default = {
    "dev" = 1
    "prod" = 5
  }
}