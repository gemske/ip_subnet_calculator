require 'ipaddress'
#puts "IP:"
ip_input = '192.168.14.0/19'

def parse_ip_input(ip_input)
  IPAddress.parse ip_input
end

def ip_array(ip)
 ip.to_a
end

def ip_bits (address)
  address.bits
end

ip = parse_ip_input(ip_input)
ip_array = ip.to_a
#ip_mask =
#ip_prefix =
ip_network = ip_array.first
ip_host_count = ip_array.length
ip_firsthost = ip_array[-2]
ip_lasthost = ip_array[1]
ip_broadcast = ip_array.last
ip_bits = ip_bits(ip)



puts "\n\n\n\n"
puts "Your IP address is #{ip}."
puts "There are a total of #{ip_array.length} address."
puts "The network address is #{ip_network}"
puts "The broadcast address is #{ip_broadcast}"
puts ""
puts "There are #{ip_host_count} hosts available"
puts "ranging from #{ip_firsthost} to #{ip_lasthost}"
puts "\n\n\n"
puts "==========================BINARY CHART============================= "
puts "\n"
puts "BINARY: #{ip_bits}"
puts "\n\n\n\n"
puts "=============================END=================================== "
puts "\n\n\n\n"
