package terraform.analysis

# Allowed AMI IDs as a set
allowed_ami_ids = {
    "ami-0123456789abcdef0",
    "ami-0fedcba9876543210"
}

deny[msg] {
    not input.ami_id
    msg := "AMI ID must be specified."
}

deny[msg] {
    input.ami_id
    not allowed_ami_ids[input.ami_id]
    msg := sprintf("AMI ID '%s' is not allowed.", [input.ami_id])
}
