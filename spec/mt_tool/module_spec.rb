require 'spec_helper'

RSpec.describe MtTool::Module do
  let(:test_path) { 'test_output' }
  let(:module_name) { 'TestModule' }
  let(:author) { 'Test Author' }
  
  before(:each) do
    FileUtils.mkdir_p(test_path)
  end

  describe '#create_viper_module' do
    it 'creates a VIPER module with all required files' do
      args = []
      options = { name: module_name, author: author, path: test_path }
      module_generator = described_class.new(args, options)
      
      module_generator.create_viper_module(test_path, module_name, 'swift', '', author)
      
      # Check if all required files are created
      expected_files = [
        'TestModuleEntity.swift',
        'TestModuleInteractor.swift',
        'TestModulePresenter.swift',
        'TestModuleRouter.swift',
        'TestModuleViewController.swift'
      ].map { |file| File.join(test_path, module_name, file) }
      
      expected_files.each do |file|
        expect(File.exist?(file)).to be true
      end
    end

    it 'includes author information in generated files' do
      args = []
      options = { name: module_name, author: author, path: test_path }
      module_generator = described_class.new(args, options)
      
      module_generator.create_viper_module(test_path, module_name, 'swift', '', author)
      
      # Check if author information is included in files
      main_file = File.join(test_path, module_name, 'TestModuleViewController.swift')
      content = File.read(main_file)
      expect(content).to include(author)
    end

    it 'generates valid Swift syntax' do
      args = []
      options = { name: module_name, author: author, path: test_path }
      module_generator = described_class.new(args, options)
      
      module_generator.create_viper_module(test_path, module_name, 'swift', '', author)
      
      # Check Swift syntax in generated files
      Dir.glob(File.join(test_path, module_name, '*.swift')).each do |file|
        content = File.read(file)
        expect(content).to match(/import (Foundation|UIKit)/)
        expect(content).to match(/class|struct|protocol|typealias\s+TestModule/)
      end
    end
  end
end 