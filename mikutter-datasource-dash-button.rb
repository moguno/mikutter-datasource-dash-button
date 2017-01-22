require_relative "settings"
require_relative "datasource"
require_relative "models"

Plugin.create(:"mikutter-datasource-dash-button") {
  def thread_proc
    while true
      command = "#{UserConfig[:dash_button_tcpdump]} arp and ether src #{UserConfig[:dash_button_mac_address]} -c 1"
      
      result = system(command)

      if result
        begin
          user = DashButtonUser.new_ifnecessary({
            :uri => URI.parse("dashbutton://singleton"),
            :idname => "Amazon Dash Button",
            :name => "Dashボタン",
            :profile_image_url => Skin["icon.png"].uri.path
          })

          message = DashButtonMessage.new_ifnecessary({
            :description => _("Dash Buttonが押されたよ"),
            :created => Time.now,
            :user => user
          })

          Plugin.call(:extract_receive_message, :mikutter_datasource_dash_button, [message])
        rescue => e
          puts e
          puts e.backtrace
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
