# A Rego custom rule to check AWS EC2 AMI IDs, for use with Regula
# See our blog post for details: https://blog.fugue.co

package rules.approved_ami

__rego__metadoc__ := {
  "id": "CUSTOM_0002",
  "title": "AWS EC2 instances must use approved AMIs",
  "description": "Per company policy, EC2 instances may only use AMI IDs from a pre-approved list",
  "custom": {
    "controls": {
      "CORPORATE-POLICY": [
        "CORPORATE-POLICY_1.2"
      ]
    },
    "severity": "High"
  }
}

resource_type = "aws_instance"

approved_amis = {
  # Ubuntu Server 20.04 LTS (HVM), SSD Volume Type
  "ami-09e67e426f25ce0d7", # us-east-1
  "ami-03d5c68bab01f3496" # us-west-2 
}

deny[msg] {
  not approved_amis[input.ami]
  msg = sprintf("%s is not an approved AMI ID", [input.ami])
}