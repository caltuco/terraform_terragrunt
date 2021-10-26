include "root" {
  path = find_in_parent_folders()
}

terraform {

  source = "../../terraform/modules//lambda"

}

dependency "dynamo" {
  config_path = "../dynamo"
}


inputs = {

function_name = "my-lambda1"
description   = "My awesome lambda function"
handler       = "handler.lambda_handler"
runtime       = "python3.8"

source_path = "/home/luis/Documents/proyectos_personal/tango-challenge/terraform/infrastructure/python_code/handler.py"


  environment_variables = {
  DYNAMO_TABLE      = dependency.dynamo.outputs.dynamodb_table_id
  }

  attach_policy_jsons = true
  policy_jsons = [file("/home/luis/Documents/proyectos_personal/tango-challenge/terraform/infrastructure/policy/lambda_policy1.json"),file("/home/luis/Documents/proyectos_personal/tango-challenge/terraform/infrastructure/policy/lambda_policy2.json")]
  number_of_policy_jsons = 2

}
