package terraform.analysis

allowed_ami_ids = {
  "ami-0123456789abcdef0",
  "ami-0fedcba9876543210"
}

deny[msg] {
  rc := input.plan.resource_changes[_]
  rc.type == "aws_instance"
  action := rc.change.actions[_]
  action == "create" or action == "update"
  ami := rc.change.after.ami
  not allowed_ami_ids[ami]
  msg := sprintf("AMI ID '%s' is not allowed for %v.", [ami, rc.address])
}
