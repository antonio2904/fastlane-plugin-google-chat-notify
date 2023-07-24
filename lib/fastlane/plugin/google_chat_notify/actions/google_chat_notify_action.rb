require 'fastlane/action'
require_relative '../helper/google_chat_notify_helper'

module Fastlane
  module Actions
    class GoogleChatNotifyAction < Action
      def self.run(params)
        
        space_id ||= params[:space_id]
        api_key ||= params[:api_key]
        token ||= params[:token]
        message ||= params[:message]
        
        # The URL to which you want to send the POST request
        url = URI.parse("https://chat.googleapis.com/v1/spaces/#{space_id}/messages?key=#{api_key}&token=#{token}")

        first_arg = ARGV[0]
        second_arg = ARGV[1]

        # The data you want to send in the request body
        data = { "text": "#{message}" }
        post_data = JSON.generate(data)

        # Create a Net::HTTP object and set up the request
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = (url.scheme == 'https')
        request = Net::HTTP::Post.new(url.request_uri)

        # Set the request headers
        request['Content-Type'] = 'application/json; charset=UTF-8'
        request['User-Agent'] = 'Gitlab CI' # You can set this to your application name

        # Set the request body
        request.body = post_data

        # Send the request and get the response
        response = http.request(request)
      end

      def self.description
        "Notify a group through google chat"
      end

      def self.authors
        ["Antony Leons"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "This plugin notifies a specified group in google chat about build pipelines"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :api_key,
                                  env_name: "GOOGLE_CHAT_NOTIFY_API_KEY",
                               description: "api key for google chat",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :token,
                                  env_name: "GOOGLE_CHAT_NOTIFY_TOKEN",
                               description: "token for google chat",
                                  optional: false,
                                      type: String) ,
         FastlaneCore::ConfigItem.new(key: :message,
                                  env_name: "GOOGLE_CHAT_NOTIFY_MESSAGE",
                               description: "message for google chat",
                                  optional: false,
                                      type: String),
         FastlaneCore::ConfigItem.new(key: :space_id,
                                  env_name: "GOOGLE_CHAT_NOTIFY_SPACE_ID",
                               description: "id of google space",
                                  optional: false,
                                      type: String)                           
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
