include "root" {
  path = find_in_parent_folders()
}

terraform {

  source = "../../terraform/modules//notifications"

}


dependency "bucket" {
  config_path = "../bucket"
}

dependency "lambda" {
  config_path = "../lambda"
}

inputs = {

create_notif_lambda = true

bucket = dependency.bucket.outputs.bucket_id


lambda_notifications = [{
  lambda_function_arn     = dependency.lambda.outputs.lambda_function_arn
  lambda_function_events  = ["s3:ObjectCreated:Put"]
  filter_prefix           = "image/"
  #filter_suffix           = ".jpeg"
}]

}
