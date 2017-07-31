require 'rubygems'
require 'ipaddress'

def ip_array
ip.each do |addr|
  addr.map { |each| }
end
end


puts "Enter IP"
ip_input = gets
ip = IPAddress ip_input
puts IPAddress
ip_array = ip_array(ip_input)
ip_array.inspect
