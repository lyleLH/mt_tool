require 'json'

$class_full_name = ARGV[0]
input_file_path = ARGV[1]

input_file = File.read(input_file_path)
input_json = JSON.parse(input_file)

input_dir = File.dirname(input_file_path)

# constants
OBJC_TYPE_STRING = "NSString *"
OBJC_TYPE_NUMBER = "NSNumber *"
OBJC_TYPE_NSDIC = "NSDictionary *"
OBJC_TYPE_ID = "id"
OBJC_TYPE_ARRAY = "NSArray *"
OBJC_TYPE_BOOL = "BOOL"
OBJC_TYPE_NULL = "NSNull *"

# attributes
ATTRIBUTE_NONATOMIC = "nonatomic"
ATTRIBUTE_COPY = "copy"
$class_full_name

$type_map = {
  "String" => OBJC_TYPE_STRING,
  "Integer" => OBJC_TYPE_NUMBER,
  "Float" => OBJC_TYPE_NUMBER,
  "Hash" => OBJC_TYPE_NSDIC,
  #"Hash" => OBJC_TYPE_ID,
  "Array" => OBJC_TYPE_ARRAY,
  "TrueClass" => OBJC_TYPE_BOOL,
  "FalseClass" => OBJC_TYPE_BOOL,
  "NilClass" => OBJC_TYPE_NULL,
}

$attr_map = {
  OBJC_TYPE_STRING => [ATTRIBUTE_NONATOMIC, ATTRIBUTE_COPY],
  OBJC_TYPE_NUMBER => [ATTRIBUTE_NONATOMIC],
  OBJC_TYPE_ID => [ATTRIBUTE_NONATOMIC],
  OBJC_TYPE_NSDIC => [ATTRIBUTE_NONATOMIC],
  OBJC_TYPE_ARRAY => [ATTRIBUTE_NONATOMIC, ATTRIBUTE_COPY],
  OBJC_TYPE_BOOL => [ATTRIBUTE_NONATOMIC],
  OBJC_TYPE_NULL => [ATTRIBUTE_NONATOMIC]
}

# generate info
$prop_declare = "@property"

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
  var_name = key
  prop_ret = "#{$prop_declare} (#{attribute}) #{type}#{var_name};"

  return prop_ret
end

# puts type_map
header_comment = <<comment
// #{$class_full_name}.h
// 
// Created by #{ENV['USER']} on #{Time.now.strftime("%Y/%m/%d")}
// Model file Generated using objc_export https://github.com/gogozs/objc_export
comment

header_result = ""
header_result << header_comment
header_result << "\n#import <Foundation/Foundation.h>\n\n"
header_result << "@interface #{$class_full_name} : NSObject\n\n"
header_file_name = "#{$class_full_name}.h"

imp_result = ""
imp_result << "#import \"#{header_file_name}\"\n\n"
imp_result << "@interface #{$class_full_name} ()\n@end\n\n"

imp_result << "@implementation #{$class_full_name}\n"
imp_result << "@end"

imp_file_name = "#{$class_full_name}.m"

input_json.each do |key, value|
  header_result << "#{prop_for_key_value(key, value)}\n"
end
header_result << "\n@end"

header_file_path = "#{input_dir}/#{header_file_name}"
imp_file_path = "#{input_dir}/#{imp_file_name}"

File.open(header_file_path, 'w') do |io|
  io << header_result
end

File.open(imp_file_path, 'w') do |io|
  io << imp_result
end

