describe Fastlane::Actions::OvoGptdriverAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The ovo_gptdriver plugin is working!")

      Fastlane::Actions::OvoGptdriverAction.run(nil)
    end
  end
end
