#!/usr/bin/env ruby
require 'net/telnet'

###
#
# methods
#
###

def do_command(ezb_conn, command)
  ezb_conn.cmd( 'String' => command,
                'Timeout' => 120,
                'Match' => DEF_MATCH_RESP) { |c| 
    return c 
  }
end

###
#
# constants
#
###

COMMAND_TMPLT = '<?xml version="1.0"?><command>%s</command>'
DEF_MATCH_RESP = /<\?xml version="1.0"\?>\n<Response> \w+\n(<Parameter\d+>.*<\/Parameter\d+>\n)+<\/Response>\n/

###
#
# main
#
###

ezb = Net::Telnet::new( "Host" => "10.0.0.145",
                        "Port" => 8002,
                        "Timeout" => 10,
                        "Prompt" => /[$%#>] \z/n)

#localhost.login("username", "password") { |c| print c }


commands = {
  :get_version => COMMAND_TMPLT % 'GetVersion',
  :get_clock => COMMAND_TMPLT % 'GetClock',
  :get_lnkdata => COMMAND_TMPLT % 'GetLnkData',
  :list_devices => COMMAND_TMPLT % 'LstDevices',
  :add_device => COMMAND_TMPLT % 'AddDevice<label>My Lamp</label><id>04.CF.5A</id><devcat>012</devcat><protocol>INSTEON</protocol>',
  :turn_on => COMMAND_TMPLT % 'SndIns 
  <parameter1>0x04</parameter1> 
  <parameter2>0xCF</parameter2> 
  <parameter3>0x5A</parameter3> 
  <parameter4>0x00</parameter4> 
  <parameter5>0x11</parameter5> 
  <parameter6>0xFF</parameter6>',
  :turn_off => COMMAND_TMPLT % 'SndIns 
  <parameter1>0x04</parameter1> 
  <parameter2>0xCF</parameter2> 
  <parameter3>0x5A</parameter3> 
  <parameter4>0x00</parameter4> 
  <parameter5>0x13</parameter5> 
  <parameter6>0x00</parameter6>',
  :inst_off => COMMAND_TMPLT % 'SndIns 
  <parameter1>0x04</parameter1> 
  <parameter2>0xCF</parameter2> 
  <parameter3>0x5A</parameter3> 
  <parameter4>0x00</parameter4> 
  <parameter5>0x14</parameter5> 
  <parameter6>0x00</parameter6>',
  :brighten => COMMAND_TMPLT % 'SndIns 
  <parameter1>0x04</parameter1> 
  <parameter2>0xCF</parameter2> 
  <parameter3>0x5A</parameter3> 
  <parameter4>0x00</parameter4> 
  <parameter5>0x15</parameter5>',  
  :dim => COMMAND_TMPLT % 'SndIns 
  <parameter1>0x04</parameter1> 
  <parameter2>0xCF</parameter2> 
  <parameter3>0x5A</parameter3> 
  <parameter4>0x00</parameter4> 
  <parameter5>0x16</parameter5>',  
  :ramped_on => COMMAND_TMPLT % 'SndIns 
  <parameter1>0x04</parameter1> 
  <parameter2>0xCF</parameter2> 
  <parameter3>0x5A</parameter3> 
  <parameter4>0x00</parameter4> 
  <parameter5>0x2E</parameter5> 
  <parameter6>0xFFFF</parameter6>',
  :ramped_off => COMMAND_TMPLT % 'SndIns 
  <parameter1>0x04</parameter1> 
  <parameter2>0xCF</parameter2> 
  <parameter3>0x5A</parameter3> 
  <parameter4>0x00</parameter4> 
  <parameter5>0x2F</parameter5> 
  <parameter6>0xFFFF</parameter6>'  
}

case ARGV.first
when 'v'
  puts do_command(ezb, commands[:get_version])
when 'clock'
 puts do_command(ezb, commands[:get_clock])
when 'lnk'
  puts do_command(ezb, commands[:get_lnkdata])
when 'list'
  puts do_command(ezb, commands[:list_devices])
when 'ioff'
  puts do_command(ezb, commands[:inst_off])
when 'dim'
  puts do_command(ezb, commands[:dim])
when 'off'
  puts do_command(ezb, commands[:turn_off])
when 'on'
  puts do_command(ezb, commands[:turn_on])  
when 'br'
  puts do_command(ezb, commands[:brighten])    
else
 puts "I don't know what you want to do"
end

ezb.close
