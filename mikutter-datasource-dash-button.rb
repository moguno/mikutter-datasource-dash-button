Plugin.create(:"mikutter-datasource-dash-button") {
  UserConfig[:dash_button_tcpdump] ||= "sudo -n tcpdump"
  UserConfig[:dash_button_mac_address] ||= "00:00:00:00:00:00"

  filter_extract_datasources { |datasources|
    datasources[:mikutter_datasource_dash_button] = _("Amazon Dash Button")

    [datasources]
  }

  settings(_("Amazon Dash Button")) {
    input(_("tcpdumpコマンドライン"), :dash_button_tcpdump)
    input(_("MACアドレス"), :dash_button_mac_address)
  }

  def thread_proc
    while true
      command = "#{UserConfig[:dash_button_tcpdump]} arp and ether src #{UserConfig[:dash_button_mac_address]} -c 1"
      
puts command

      result = system(command)

puts result

      if result
begin
        message = Message.new(:message => _("Dash Buttonが押されたよ"), :system => true)
        Plugin.call(:extract_receive_message, :mikutter_datasource_dash_button, Messages.new([message]))
rescue => e
puts e
end
      else
        activity(:system, "tcpdumpの起動に失敗しました。")
        sleep(60)
      end 
    end
  end

  on_boot { |service|
    if service == Service.primary
      Thread.new {
        thread_proc
      }
    end
  }
}
