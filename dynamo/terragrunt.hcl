include "root" {
  path = find_in_parent_folders()
}

terraform {
source = "../../terraform/modules//dynamo"

}


inputs = {

create_table = true

table_name       = "table_1"
billing_mode     = "PROVISIONED"
hash_key         = "ID"
range_key        = "name"
read_capacity    = 1
write_capacity   = 2

autoscaling_read = {
scale_in_cooldown  = 50
scale_out_cooldown = 40
target_value       = 50
max_capacity       = 5
}

autoscaling_write = {
scale_in_cooldown  = 50
scale_out_cooldown = 40
target_value       = 70
max_capacity       = 10
}


attributes = [
  {
    name = "ID"
    type = "S"
  },
  {
    name = "name"
    type = "S"
  }
]

 }
