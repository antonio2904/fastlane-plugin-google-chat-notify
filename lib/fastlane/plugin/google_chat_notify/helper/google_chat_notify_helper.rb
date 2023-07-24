require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class GoogleChatNotifyHelper
      # class methods that you define here become available in your action
      # as `Helper::GoogleChatNotifyHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the google_chat_notify plugin helper!")
      end
    end
  end
end
