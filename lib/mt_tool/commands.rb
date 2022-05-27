
require 'thor'
require 'mt_tool/module/module'
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


  end
end
