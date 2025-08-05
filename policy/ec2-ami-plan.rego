flow:
  - type: "terraformPlan"
    step: 100
    name: "OPA Check Against Terraform Plan"
    commands:
      - runtime: "GROOVY"
        priority: 100
        after: true
        script: |
          import Opa
          new Opa().loadTool("$workingDirectory", "$bashToolsDirectory", "0.44.0")
          "OPA Download Completed..."

      - runtime: "BASH"
        priority: 200
        after: true
        script: |
          cd $workingDirectory
          echo "Creating Terraform plan..."
          terraform plan -out=tfplan.binary

          echo "Exporting plan to JSON..."
          terraform show -json tfplan.binary > tfplan.json

          echo "Running OPA policy check against plan..."
          opa eval --stdin-input --data policy/ --format pretty \
            "data.terraform.analysis.deny" < tfplan.json > opa_result.json

          opa_violations=$(jq 'length' opa_result.json)

          if [ "$opa_violations" -eq 0 ]; then
            echo "✅ OPA plan check passed: no violations detected."
            exit 0
          else
            echo "❌ OPA plan check failed: violations detected:"
            cat opa_result.json
            exit 1
          fi
