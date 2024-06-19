require 'json'
require 'thor'
require 'active_support/all'

module MtTool

  class OcModel < Thor

    # constants
    OBJC_TYPE_STRING = "NSString *"
    OBJC_TYPE_NUMBER = "NSNumber *"
    OBJC_TYPE_ID = "id"
    OBJC_TYPE_NSDIC = "NSDictionary *"

    OBJC_TYPE_ARRAY = "NSArray *"
    OBJC_TYPE_BOOL = "BOOL"
    OBJC_TYPE_NULL = "NSNull *"

    # attributes
    ATTRIBUTE_NONATOMIC = "nonatomic"
    ATTRIBUTE_COPY = "copy"
    ATTRIBUTE_STRONG= "strong"
    ATTRIBUTE_ASSIGN= "assign"

    $type_map = {
      "String" => OBJC_TYPE_STRING,
      "Integer" => OBJC_TYPE_NUMBER,
      "Float" => OBJC_TYPE_NUMBER,
      # "Hash" => OBJC_TYPE_ID,
      "Hash" => OBJC_TYPE_NSDIC,
      "Array" => OBJC_TYPE_ARRAY,
      "TrueClass" => OBJC_TYPE_BOOL,
      "FalseClass" => OBJC_TYPE_BOOL,
      "NilClass" => OBJC_TYPE_NULL,
    }

    $attr_map = {
      OBJC_TYPE_STRING => [ATTRIBUTE_NONATOMIC, ATTRIBUTE_COPY],
      OBJC_TYPE_NUMBER => [ATTRIBUTE_NONATOMIC,ATTRIBUTE_COPY],
      OBJC_TYPE_ID => [ATTRIBUTE_NONATOMIC,ATTRIBUTE_COPY],
      OBJC_TYPE_NSDIC => [ATTRIBUTE_NONATOMIC,ATTRIBUTE_COPY],
      OBJC_TYPE_ARRAY => [ATTRIBUTE_NONATOMIC, ATTRIBUTE_COPY],
      OBJC_TYPE_BOOL => [ATTRIBUTE_NONATOMIC,ATTRIBUTE_ASSIGN],
      OBJC_TYPE_NULL => [ATTRIBUTE_NONATOMIC,ATTRIBUTE_ASSIGN]
    }

    # generate info
    $prop_declare = "@property"

    include Thor::Actions

    def initialize(args = [], options = {}, config = {})
      super

    end

    no_commands do

      def qt_create(prefix,name, path = nil ,output_path = nil)

        @json_path = path
        @class_full_name = name
        @file_name = name+'Model'
        @output_path = output_path
        system "quicktype --src #{path} --src-lang json --class-prefix #{prefix}  --lang objc --top-level #{name} -o #{output_path}/#{prefix+name}   --just-types "
      end

      def create(prefix,name, path = nil ,output_path = nil)

        @json_path = path
        @prefix = prefix
        @class_full_name = name
        @file_name = prefix+name+'Model'
        @output_path = output_path
        operate
      end

      def operate

        input_file = File.read(@json_path)
        input_json = JSON.parse(input_file)


        header_result = ""
        result = add_header_with_kv input_json
        header_result <<  result


        imp_result = add_imp_with_kv input_json


        header_file_name = "#{@file_name}.h"
        header_file_path = "#{@output_path}/#{header_file_name}"
        imp_file_name = "#{@file_name}.m"
        imp_file_path = "#{@output_path}/#{imp_file_name}"

        File.open(header_file_path, 'w') do |io|
          io << header_result
        end

        File.open(imp_file_path, 'w') do |io|
          io << imp_result
        end

      end



      def add_header_with_kv(json)

        header_comment = <<comment
// #{@class_full_name}.h
// 
// Created by #{ENV['USER']} on #{Time.now.strftime("%Y/%m/%d")}
comment

        header_result = ''
        header_result << header_comment
        header_result << "\n\n\n"
        header_result << "#import <Foundation/Foundation.h>\n\n"
        header_result << "@interface #{@file_name} : NSObject\n\n"

        sub_model_types = []
        sub_model_kvs = {}

        json.each do |key, value|
          if value.class == Hash
            attribute = attr_name_for_attr_array [ATTRIBUTE_NONATOMIC,ATTRIBUTE_STRONG]
            type = @prefix+@class_full_name + key.camelize(:upper) + "Model"
            var_name = key
            header_result << "#{$prop_declare} (#{attribute}) #{type +" *"}#{var_name};\n"
            sub_model_types.push type
            sub_model_kvs[type] = value
          elsif value.class == Array

            attribute = attr_name_for_attr_array [ATTRIBUTE_NONATOMIC,ATTRIBUTE_STRONG]
            type = @prefix+@class_full_name + key.camelize(:upper) + "Model"
            var_name = key
            header_result << "#{$prop_declare} (#{attribute}) NSArray <#{type+" *"}>*#{var_name};\n"
            sub_model_types.push type
            sub_model_kvs[type] = value
          else
            header_result << "#{prop_for_key_value(key, value)}\n"

          end

        end

        header_result << "\n@end"


        sub_model_types.each do |type|
          header_result << "\n\n@interface #{type} : NSObject\n\n"

          header_result << "\n@end\n"
        end
        header_result
      end





      def add_imp_with_kv(json)
        imp_comment = <<comment
// #{@class_full_name}.h
// 
// Created by #{ENV['USER']} on #{Time.now.strftime("%Y/%m/%d")}
comment

        imp_result = ""
        imp_result << imp_comment
        imp_result << "\n\n\n"
        imp_result << "#import \"#{@prefix+@class_full_name}\"\n\n"
        imp_result << "@interface #{@prefix+@class_full_name} ()\n\n\n@end\n\n"

        imp_result << "@implementation #{@prefix+@class_full_name}\n"
        imp_result << "\n\n@end"
        imp_result << "\n\n------------\n"
        sub_model_types = []


        json.each do |key, value|
          if value.class == Hash
            type = @prefix+@class_full_name + key.camelize(:upper) + "Model"
            sub_model_types.push type
          elsif value.class == Array
            type = @prefix+@class_full_name + key.camelize(:upper) + "Model"
            sub_model_types.push type
          else

          end

        end
        sub_model_types.each do |type|
          imp_result << "\n\n@implementation #{type} "

          imp_result << "\n@end\n"
        end
        imp_result

      end

      def attr_name_for_attr_array(attr_array)
        attr_name = ""

        attr_array.each_with_index do |attribute, index|
          if index != 0
            attr_name << ", #{attribute}"
          else
            attr_name << "#{attribute}"
          end

        end

        return attr_name
      end

      def prop_for_key_value(key, value)
        type = $type_map["#{value.class}"]
        attribute = attr_name_for_attr_array($attr_map[type])
        var_name = key.camelize(:lower)
        if key =='id'
          var_name = 'ID'
        end
        prop_ret = "#{$prop_declare} (#{attribute}) #{type}#{var_name};"

        return prop_ret
      end



    end
  end
end