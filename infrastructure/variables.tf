# Provider configuration - no longer necessary, passed via environment variables ARM_*
variable "azure_client_id" {
  description = "Service principle client ID"
  type        = string
  sensitive   = true
}

# not used any more - replaced by ARM_CLIENT_SECRET for localhost runs only.
# variable "azure_client_secret" {
#   description = "Service principle password"
#   type        = string
#   sensitive   = true
#   default     = ""
# }

variable "azure_subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "azure_tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

# variable "azure_sp_object_id" {
#   description = "Service principle object ID - the enterprise application object ID!"
#   type        = string
# }

variable "developer_localhost_object_id" {
  description = "Object ID of the service principle running in container on developers localhost"
  type        = string
}

variable "managed_identity_github_actions_object_id" {
  description = "Object ID of the managed identity running infrastructure in Github Actions pipline"
  type        = string
}

# Project configuration:
variable "project_name" {
  description = "Name of the project - used for ressource names"
  type        = string
}

variable "project_short_name" {
  description = "Abbreviation of project name - used for ressource names with size restrictions"
  type        = string
}

variable "costcenter" {
  description = "Organisation internal name of costcenter"
  type        = string
}

variable "owner_name" {
  description = "Organisation internal name of owner"
  type        = string
}

variable "budget_notification_email" {
  description = "Email adress for budget notifications"
  type        = string
}

# variable "owner_user_principal_name" {
#   description = "User principal name of desired owner"
#   type        = string
# }

variable "owner_object_id" {
  description = "Object ID of desired owner"
  type        = string

}