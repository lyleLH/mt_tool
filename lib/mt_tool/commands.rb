require 'colored2'
require 'thor'
require 'fileutils'
require 'psych'
require 'yaml'
require 'mt_tool/analyze'
module MtTool
  class CLI < Thor
    include Thor::Actions

    CONFIG_FILE = '.MTModuleFilesConfig.yml'.freeze

    desc 'generate <Path> <Module Name> <Language> <Prefix - 前缀> <Author - 作者>', '直接生成项目 例子： yk_command generate  . HomeModule oc MT Tom.Liu '
    method_option :generate, aliases: '-g'
    def generate(path = nil,name,lang ,class_prefix,author)
      @name = name
      @module = @name
      @lang = lang
      @class_prefix = class_prefix
      @final_path = "#{path}/#{@name}"
      @author = author
      @prefixed_module = @class_prefix + @module

      say "generating file in path:#{@final_path}", :green

      if File.exist?(@final_path.to_s)
        say "#{@final_path} 已存在:", :red
      else
        prepare_folder
        if File.exist?("#{@final_path}/configure")
          system("#{@final_path}/configure", @name, @lang, @class_prefix, *@additional_args)
        else
          say 'Template does not have a configure file', :red
        end
        yk_module_folders
        yk_template_files
      end
    end

    desc 'create <Path>', '在某个路径下交互式生成项目'
    method_option :create, aliases: '-c'
    def create(path = nil)
      path = Dir.pwd if path.nil?

      say '模块名:', :green
      config_file_path = "#{path}/#{CONFIG_FILE}"
      config = File.exist?(config_file_path) ? YAML.load_file(config_file_path) : {}
      input_name = ask("Project name [#{config[:project]}] ?")

      if input_name != ''
        @name = input_name
        config[:project] = input_name if input_name != config[:project]
      else
        @name = config[:project]
      end

      File.open(config_file_path, 'w') do |f|
        f.write config.to_yaml
      end

      @final_path = "#{path}/#{@name}"

      if File.exist?(@final_path.to_s)
        say "#{@final_path} 已存在:", :red
      else
        prepare_folder
        read_config(path)

        if File.exist?("#{@final_path}/configure")
          system("#{@final_path}/configure", @name, @lang, @class_prefix, *@additional_args)
        else
          say 'Template does not have a configure file', :red
        end

        yk_module_folders
        yk_template_files

      end
    end

    no_commands do
      def read_config(path)
        config_file_path = "#{path}/#{CONFIG_FILE}"
        config = File.exist?(config_file_path) ? YAML.load_file(config_file_path) : {}

        project = @name
        say '语言:', :green
        language = ask("Project language [#{config[:language]}] ?", limited_to: ['objc', 'swift', ''])
        say '类名前缀:', :green
        class_prefix = ask("Class prefix [#{config[:class_prefix]}] ?")
        say '文件作者:', :green
        author = ask("Author [#{config[:author]}] ?")

        config[:project]      = project.empty?      ? config[:project] || ''      : project
        config[:language]     = language.empty?     ? config[:language] || 'objc' : language
        config[:class_prefix] = class_prefix.empty? ? config[:class_prefix] || '' : class_prefix
        config[:author]       = author.empty?       ? config[:author] || ''       : author

        File.open(config_file_path, 'w') do |f|
          f.write config.to_yaml
          # f.write YAML.to_yaml(config)
        end

        @module = @name
        @class_prefix = config[:class_prefix]
        @prefixed_module = config[:class_prefix] + @module
        @project         = config[:project]
        @author          = config[:author]
        @date            = Time.now.strftime('%d/%m/%y')
        @lang = config[:language]
      end

      def prepare_folder

        template_repo_url = 'https://github.com/lyleLH/MTTemplate.git'
        system("git clone #{template_repo_url} #{@final_path}")

        # FileUtils.remove_dir(@final_path, true)
        # FileUtils.cp_r('/Users/imacn24/Documents/dev/YKProjectTemplate', @final_path)
        # FileUtils.remove_dir("#{@final_path}/.git", true)
      end

      def yk_module_folders
        class_folder_path = "#{@final_path}/#{@name}/Classes"

        first_level_folders = %w[Public Private]

        # public_level_folders = ['Register']
        # public_level_folders.each do |folder|
        #   path = "#{class_folder_path}/Public/#{folder}"
        #   empty_directory path
        # end

        private_level_folders = %w[Business Category Vendor Tools]

        first_level_folders.each do |folder|
          path = "#{class_folder_path}/#{folder}"
          empty_directory path
        end



        private_level_folders.each do |folder|
          path = "#{class_folder_path}/Private/#{folder}"
          empty_directory path
        end
      end

      CLI.source_root(File.dirname(__FILE__))

      def yk_template_files
        register_path = "#{@final_path}/#{@name}/Classes/Private/Register"
        registger = {
          'RouterRegister.h'     => 'RouterRegister',
          'RouterRegister.m'     => 'RouterRegister',
          'ServiceRegister.h'     => 'ServiceRegister',
          'ServiceRegister.m'     => 'ServiceRegister'
        }

        registger.each do |file_name, _folder|
          final_file = "#{register_path}/#{@prefixed_module}#{file_name}"
          template "#{__dir__}/template/objc/#{file_name}", final_file
        end

        public_folder_path = "#{@final_path}/#{@name}/Classes/Public"

        template_code_filename = ['ServiceProtocol.h','RouterDefine.h']
        template_code_filename.each do |file_name|
          final_file = "#{public_folder_path}/#{@prefixed_module}#{file_name}"
          source = "#{__dir__}/template/objc/#{file_name}"
          template source, final_file
        end

        swift_template_code_filename = ['RouterDefine.swift']
        swift_template_code_filename.each do |file_name|
          final_file = "#{public_folder_path}/#{@prefixed_module}_Swift_#{file_name}"
          source = "#{__dir__}/template/swift/#{file_name}"
          template source, final_file
        end



        private_folder_path = "#{@final_path}/#{@name}/Classes/Private"
        #pch file
        # pch_file_name = "PrefixHeader.pch"
        # final_file = "#{private_folder_path}/#{@prefixed_module}#{pch_file_name}"
        # source = "#{__dir__}/template/objc/#{pch_file_name}"
        # template source, final_file

        private_level_folder_files = {
          'PrefixHeader.pch'     => 'Business',
          'CategoryHeader.h'     => 'Category',
          'ToolsHeader.h'     => 'Tools',
          'vendorHeader.h'     => 'Vendor'
        }

        private_level_folder_files.each do |file_name, folder|
          final_prefix = @prefixed_module
          if file_name == 'PrefixHeader.pch'
            final_prefix = @module
          end

          final_file = "#{private_folder_path}/#{folder}/#{final_prefix}#{file_name}"
          source = "#{__dir__}/template/objc/#{file_name}"
          template source, final_file
        end

        business_demo_path = "#{@final_path}/#{@name}/Classes/Private/Business"
        demo_replace_file = ['DemoViewController.h','DemoViewController.m','DemoViewModel.h','DemoViewModel.m']
        demo_replace_file.each do |file_name|
          final_file = "#{business_demo_path}/Demo/#{@prefixed_module}#{file_name}"
          source = "#{__dir__}/template/objc/demo/#{file_name}"
          template source, final_file
        end



        Dir.chdir("#{@final_path}/Example") do
          system 'pod install'
          system "open './#{@name}.xcworkspace'"
        end
      end

    end

    desc 'dependency <Podfile.lock Path>', '解析Podfile.lock'
    method_option :dependency, aliases: '-d'
    def dependency(path = nil)
      say 'start resolve dependency',:green

      analyzer = Analyzer.new
      result = analyzer.analyze(path)
      pp result

    end
  end
end
