
require 'thor'
require 'mt_tool/module/module'
require 'mt_tool/oc_model/oc_model'

module MtTool
  class CLI < Thor
    include Thor::Actions


    desc 'generate <Path> <Module Name> <Language> <Prefix - 前缀> <Author - 作者>', '直接生成项目 例子： yk_command generate  . HomeModule oc MT Tom.Liu '
    method_option :generate, aliases: '-g'

    def generate(path = nil, name, lang, class_prefix, author)
      Module.new(self .args,self .options).generate(path, name, lang, class_prefix, author)
    end

    desc 'create <Path>', '在某个路径下交互式生成项目'
    method_option :create, aliases: '-c'

    def create(path = nil)
      Module.new(self .args,self .options ).create(path)

    end


    desc 'vmod  <module name > <author> <path> ', '生成viper模块文件'
    method_option :vmod, aliases: '-v'
    def generateViperModule(name,author, path )
      Module.new(self .args,self .options).create_viper_module(path, name, "swift","", author)
    end

    desc 'model_class <prefix> <class name > <json file path> <output path>', '根据json文件生成模型类'
    method_option :create, aliases: '-c'
    def model_class(prefix,name, path ,output_path)
      OcModel.new(self .args,self .options ).create(prefix,name ,path,output_path)

    end

    desc 'qt_model_class <prefix> <class name > <json file path> <output path>', '使用quicktype根据json文件生成模型类'
    method_option :create, aliases: '-c'
    def qt_model_class(prefix,name, path ,output_path)
      OcModel.new(self .args,self .options ).qt_create(prefix,name ,path,output_path)

    end



  end
end
