package terraform.analysis

allowed_ami_ids = {
    "ami-0123456789abcdef0",
    "ami-0fedcba9876543210"
}

deny[msg] {
    some r
    input.resources[r].type == "aws_instance"

    some i
    ami := input.resources[r].instances[i].attributes.ami

    not ami
    msg := "AMI ID must be specified."
}

deny[msg] {
    some r
    input.resources[r].type == "aws_instance"

    some i
    ami := input.resources[r].instances[i].attributes.ami

    not allowed_ami_ids[ami]
    msg := sprintf("AMI ID '%s' is not allowed.", [ami])
}
