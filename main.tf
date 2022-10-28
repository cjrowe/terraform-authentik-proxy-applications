resource authentik_outpost "proxy_outpost" {
  count = length(var.applications) == 0 ? 0 : 1

  name = "Proxy Outpost"
  type = "proxy"
  protocol_providers = authentik_provider_proxy.proxy_provider[*].id
  service_connection = var.service_connection_id
  config = var.outpost_configuration
}

resource authentik_provider_proxy "proxy_provider" {
  count = length(var.applications)

  name = "${title(var.applications[count.index].slug)}Proxy"
  external_host = var.applications[count.index].external_host
  authorization_flow = var.applications[count.index].authorization_flow_id
}

resource authentik_group "ldap_application_users" {
  count = length(var.applications)

  name = "app-users-${var.applications[count.index].slug}"
  users = var.applications[count.index].user_ids
}

resource authentik_application "proxy_application" {
  count = length(var.applications)

  name = var.applications[count.index].name
  slug = var.applications[count.index].slug

  group = lookup(var.applications[count.index].app_config, "group", "")
  meta_description = lookup(var.applications[count.index].app_config, "description", "")
  meta_launch_url = lookup(var.applications[count.index].app_config, "launch_url", "")
  meta_publisher = lookup(var.applications[count.index].app_config, "publisher", "")

  protocol_provider = authentik_provider_proxy.proxy_provider[count.index].id
}