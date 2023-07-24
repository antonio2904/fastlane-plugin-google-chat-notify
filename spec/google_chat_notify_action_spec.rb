describe Fastlane::Actions::GoogleChatNotifyAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The google_chat_notify plugin is working!")

      Fastlane::Actions::GoogleChatNotifyAction.run(nil)
    end
  end
end
