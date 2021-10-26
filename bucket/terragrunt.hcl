include "root" {
  path = find_in_parent_folders()
}

terraform {
source = "../../terraform/modules//bucket"

}



inputs = {

      buckets_parameters = [
                    {
                     "bucket" = "terragrunt-public",
                      "acl" = "public-read",
                      "policy" = "~/Documents/proyectos_personal/tango-challenge/terraform/infrastructure/policy/policy.tpl",
                      "website" = {"index_document" = "index.html"
                                    "error_document" = "error.html"}
                    },
                    {
                     "bucket" = "terragrunt-private",
                      "acl" = "private",
                      "policy" = "",
                      "website" = {}
                    }

      ]

}
