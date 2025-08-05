package terraform.analysis

import input as tfplan

allowed_ami_ids = ["ami-12345678", "ami-87654321"]

violations[address] {
    resource := tfplan.resource_changes[address]
    resource.type == "aws_instance"
    action := resource.change.actions[_]
    action in ["create", "update"]
    ami_id := resource.change.after.ami
    not ami_id in allowed_ami_ids
}

authz {
    count(violations) == 0
}