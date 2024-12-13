require 'spec_helper'

RSpec.describe MtTool::CLI do
  let(:cli) { described_class.new }
  let(:test_path) { 'test_output' }

  before(:each) do
    FileUtils.mkdir_p(test_path)
  end

  describe '#vmod' do
    it 'generates a VIPER module through CLI' do
      # Simulate CLI options
      allow(cli).to receive(:options).and_return({
        name: 'TestModule',
        author: 'Test Author',
        path: test_path
      })

      # Execute the command
      expect { cli.vmod }.not_to raise_error

      # Verify the module was created
      expect(Dir.exist?(File.join(test_path, 'TestModule'))).to be true
      expect(Dir.glob(File.join(test_path, 'TestModule', '*.swift')).length).to eq(5)
    end

    it 'logs debug information during generation' do
      # Capture log output
      log_output = StringIO.new
      logger = Logger.new(log_output)
      allow(Logger).to receive(:new).and_return(logger)

      # Simulate CLI options
      allow(cli).to receive(:options).and_return({
        name: 'TestModule',
        author: 'Test Author',
        path: test_path
      })

      # Execute the command
      cli.vmod

      # Verify logging
      log_content = log_output.string
      expect(log_content).to include('VIPER Module Generation Started')
      expect(log_content).to include('Successfully generated VIPER module')
    end

    it 'handles errors gracefully' do
      # Simulate CLI options with invalid path
      allow(cli).to receive(:options).and_return({
        name: 'TestModule',
        author: 'Test Author',
        path: '/nonexistent/path'
      })

      # Execute the command and expect error handling
      expect { cli.vmod }.to raise_error(Errno::EROFS)
    end
  end
end 