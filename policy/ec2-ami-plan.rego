package terraform.analysis

allowed_ami_ids = {
  "ami-0123456789abcdef0",
  "ami-0fedcba9876543210"
}

# Deny on create
deny[msg] {
  rc := input.plan.resource_changes[_]
  rc.type == "aws_instance"
  rc.change.actions[_] == "create"
  ami := rc.change.after.ami
  not allowed_ami_ids[ami]
  msg := sprintf("EC2 '%s' uses disallowed AMI '%s' on create", [rc.address, ami])
}

# Deny on update
deny[msg] {
  rc := input.plan.resource_changes[_]
  rc.type == "aws_instance"
  rc.change.actions[_] == "update"
  ami := rc.change.after.ami
  not allowed_ami_ids[ami]
  msg := sprintf("EC2 '%s' updates to disallowed AMI '%s'", [rc.address, ami])
}
