variable "service_connection_id" {
  type = string
  description = "Service Connection used to create LDAP Outpost"
}

variable "outpost_configuration" {
  type = string
  description = "Specific configuration details for outpost. Should be formatted as Json string"
}

variable "applications" {
  type = list(object({
    name = string
    slug = string
    external_host = string
    authorization_flow_id = string
    app_config = map(string)
    user_ids = list(string)
  }))
  description = "Details of Proxy authenticated applications to create"
}