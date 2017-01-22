Plugin.create(:"mikutter-datasource-dash-button") {
  UserConfig[:dash_button_tcpdump] ||= "sudo -n tcpdump"
  UserConfig[:dash_button_mac_address] ||= "00:00:00:00:00:00"

  settings(_("Amazon Dash Button")) {
    input(_("tcpdumpコマンドライン"), :dash_button_tcpdump)
    input(_("MACアドレス"), :dash_button_mac_address)
  }
}
