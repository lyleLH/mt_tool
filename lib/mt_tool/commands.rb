require 'thor'
require 'mt_tool/module/module'
require 'logger'

module MtTool
  class CLI < Thor
    include Thor::Actions

    def initialize(*args)
      super
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::DEBUG
      @logger.formatter = proc do |severity, datetime, progname, msg|
        "[#{severity}][#{datetime.strftime('%Y-%m-%d %H:%M:%S.%L')}] #{msg}\n"
      end
    end

    def self.exit_on_failure?
      true
    end

    desc 'vmod', '生成viper模块文件'
    method_option :name, aliases: '-n', desc: 'Module name', required: true
    method_option :author, aliases: '-a', desc: 'Author name', required: true
    method_option :path, aliases: '-p', desc: 'Target path', required: true
    def vmod
      name = options[:name]
      author = options[:author]
      path = options[:path]

      @logger.debug "====== VIPER Module Generation Started ======"
      @logger.debug "Command Parameters:"
      @logger.debug "  - Module name: #{name}"
      @logger.debug "  - Author: #{author}"
      @logger.debug "  - Path: #{path}"
      @logger.debug "Thor Options: #{options.inspect}"
      @logger.debug "Thor Arguments: #{args.inspect}"

      begin
        @logger.debug "Creating new Module instance..."
        module_instance = Module.new(self.args, self.options)
        
        @logger.debug "Calling create_viper_module..."
        module_instance.create_viper_module(path, name, "swift", "", author)
        
        @logger.info "Successfully generated VIPER module: #{name}"
        @logger.debug "====== VIPER Module Generation Completed ======"
      rescue => e
        @logger.error "Failed to generate VIPER module: #{e.message}"
        @logger.debug "Error backtrace:"
        @logger.debug e.backtrace.join("\n")
        @logger.debug "====== VIPER Module Generation Failed ======"
        raise e
      end
    end
  end
end
