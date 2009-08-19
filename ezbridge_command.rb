require 'rubygems'
require 'xmlsimple'
  
class EZBridgeCommand
  attr_reader :command, :params
  attr_writer :command, :params
  
  def initialize(command, *params)
    @command = command
    @params = params
    to_s
  end
  
  def add_param
  end
  
  def swap_param
  end
  
  def delete_param
  end
  
  def del_param
    delete_param
  end
  
  def to_s
    return "#{@command.inspect}\n#{@params.inspect}"
  end

end

ezbc1 = EZBridgeCommand.new("test", "a", "b", "c")
puts ezbc1.to_s

ref = XmlSimple.xml_out({'Command' => {'name' => 'test', 'Parameter1' => 'Paramater ABC'}})
puts ref

xml = XmlSimple.xml_in("<Command>GetTime<Parameter 1>Param1</Parameter 1><Parameter 2>Param2</Parameter 2></Command>")
puts xml.to_hash.inspect