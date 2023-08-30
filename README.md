<!-- BEGIN_TF_DOCS -->
# terraform-aws-secrets-manager

This module manage the AWS Secrets Manager secret.

## Usage

### Basic

```hcl
include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../..//."
}

inputs = {
  enabled = true

  region      = "us-east-2"
  environment = "test"
  name        = "example"

  secret_version = {
    secret_string = jsonencode(
      {
        ssh_public_key  = "ssh-rsa AAAAB3NzaC1yc2"
        ssh_private_key = "private key"
      }
    )
  }

  kms_key = {
    enabled = false
  }

  tags = {
    "Company" = "DeveloperTown"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.36.1 |

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_rotation.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_rotation) | resource |
| [aws_secretsmanager_secret_version.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_version.ignore_changes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description of the secret. | `string` | `"Managed by Terraform"` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_force_overwrite_replica_secret"></a> [force\_overwrite\_replica\_secret](#input\_force\_overwrite\_replica\_secret) | Whether to overwrite a secret with the same name in the destination Region. | `bool` | `true` | no |
| <a name="input_kms_key"></a> [kms\_key](#input\_kms\_key) | enabled:<br>    Whether to create KSM key.<br>description:<br>    The description of the key as viewed in AWS console.<br>alias:<br>    The display name of the alias. The name must start with the word alias followed by a forward slash.<br>    If not specified, the alias name will be auto-generated.<br>deletion\_window\_in\_days:<br>    Duration in days after which the key is deleted after destruction of the resource<br>enable\_key\_rotation:<br>    Specifies whether key rotation is enabled. | <pre>object({<br>    enabled                 = optional(bool, true)<br>    description             = optional(string, "Managed by Terraform")<br>    alias                   = optional(string)<br>    deletion_window_in_days = optional(number, 30)<br>    enable_key_rotation     = optional(bool, true)<br>  })</pre> | `{}` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | ARN or Id of the AWS KMS customer master key (CMK) to be used to encrypt the secret values in the versions stored in this secret.<br>If you don't specify this value, then Secrets Manager defaults to using the AWS account's default CMK (the one named `aws/secretsmanager`). | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `"ecs-cluster"` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | Valid JSON document representing a resource policy. | `string` | `null` | no |
| <a name="input_recovery_window_in_days"></a> [recovery\_window\_in\_days](#input\_recovery\_window\_in\_days) | Valid JSON document representing a resource policy. | `number` | `30` | no |
| <a name="input_region"></a> [region](#input\_region) | The region in which the resources will be created | `string` | `null` | no |
| <a name="input_replicas"></a> [replicas](#input\_replicas) | kms\_key\_id:<br>    ARN, Key ID, or Alias of the AWS KMS key within the region secret is replicated to.<br>region:<br>    Region for replicating the secret. | <pre>list(<br>    object(<br>      {<br>        kms_key_id = string<br>        region     = string<br>      }<br>    )<br>  )</pre> | `[]` | no |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | The ARN of the role that will be assumed to create the resources in this module | `string` | `null` | no |
| <a name="input_rotation"></a> [rotation](#input\_rotation) | enabled:<br>    Whether to create secret rotation rule.<br>    Default value: `false`<br>lambda\_arn:<br>    Specifies the ARN of the Lambda function that can rotate the secret.<br>automatically\_after\_days:<br>    Specifies the number of days between automatic scheduled rotations of the secret. | <pre>object({<br>    enabled                  = optional(bool, false)<br>    lambda_arn               = string<br>    automatically_after_days = number<br>  })</pre> | <pre>{<br>  "automatically_after_days": 0,<br>  "lambda_arn": ""<br>}</pre> | no |
| <a name="input_secret_version"></a> [secret\_version](#input\_secret\_version) | ignore\_changes\_enabled:<br>    Whether to ignore changes in `secret_string` and `secret_binary`.<br>    Default value: `false`<br>secret\_string:<br>    Specifies text data that you want to encrypt and store in this version of the secret.<br>    This is required if `secret_binary` is not set.<br>secret\_binary:<br>    Specifies binary data that you want to encrypt and store in this version of the secret.<br>    This is required if `secret_string` is not set.<br>    Needs to be encoded to base64. | <pre>object({<br>    secret_string          = optional(string, "{}")<br>    secret_binary          = optional(string)<br>    ignore_changes_enabled = optional(bool, false)<br>  })</pre> | `{}` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | Suffix to be added to the name of each resource | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'Unit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the secret |
| <a name="output_id"></a> [id](#output\_id) | ID of the secret |
| <a name="output_kms_key_alias_arn"></a> [kms\_key\_alias\_arn](#output\_kms\_key\_alias\_arn) | KMS key alias ARN |
| <a name="output_kms_key_alias_name"></a> [kms\_key\_alias\_name](#output\_kms\_key\_alias\_name) | KMS key alias name |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | KMS key ARN |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | KMS key ID |
| <a name="output_name"></a> [name](#output\_name) | Name of the secret |
| <a name="output_version_id"></a> [version\_id](#output\_version\_id) | The unique identifier of the version of the secret. |
<!-- END_TF_DOCS -->