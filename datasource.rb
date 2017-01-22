Plugin.create(:"mikutter-datasource-dash-button") {
  filter_extract_datasources { |datasources|
    datasources[:mikutter_datasource_dash_button] = _("Amazon Dash Button")

    [datasources]
  }
}
