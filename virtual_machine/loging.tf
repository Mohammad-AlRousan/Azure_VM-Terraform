data "azurerm_monitor_diagnostic_categories" "this" {
  count = var.nb_instances
  resource_id = local.is_windows ? azurerm_virtual_machine.vm_windows[count.index].id : azurerm_virtual_machine.vm_linux[count.index].id
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
  for_each           = coalesce(var.diagnostic_setting, {})
  name               = "AzureDiagnostics"
  target_resource_id = local.is_windows ? azurerm_virtual_machine.vm_windows[0].id : azurerm_virtual_machine.vm_linux[0].id

  storage_account_id         = try(each.value.storage_account_id, null)
  log_analytics_workspace_id = coalesce(each.value.log_analytics_workspace_id, null)

  dynamic "enabled_log" {
    for_each = coalesce(each.value.log_type, data.azurerm_monitor_diagnostic_categories.this[0].log_category_types)
    content {
      category = try(enabled_log.value.category, enabled_log.value)
      retention_policy {
        days    = try(enabled_log.value.retention, 365)
        enabled = true
      }
    }
  }
  dynamic "metric" {
    for_each = coalesce(each.value.metric_type, data.azurerm_monitor_diagnostic_categories.this[0].metrics)
    content {
      category = try(metric.value.category, metric.value)
      retention_policy {
        days    = try(metric.value.retention, 365)
        enabled = true
      }
    }
  }
}
