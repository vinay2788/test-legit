package terraform.analysis

import input as tfplan

# only these AMIs are allowed
allowed_ami_ids = ["ami-12345678", "ami-87654321"]

# find any aws_instance create/update with a disallowed AMI
violations[addr] {
  resource := tfplan.resource_changes[_]
  addr     := resource.address
  resource.type == "aws_instance"
  action   := resource.change.actions[_]
  action in ["create", "update"]
  ami_id   := resource.change.after.ami
  not ami_id in allowed_ami_ids
}

# authorization only passes if no violations
authz {
  count(violations) == 0
}
