require 'rubygems'  # optional
require 'ipaddress'
# this is defining the function to convert to binary from ip array
def to_binary_octets(address_input)
  address_arr = address_input.split('.')
  binary_arr = address_arr.map do |octet|     #these two lines are turning the values of the array into integers, back to strings
    octet.to_i.to_s(2).ljust(8, '0')         #of binary, and making sure there are 8 values
  end
  binary_arr.join                            #this joins the octets together into a 32 bit string
end

#This function will pull out the network or host portion
def binary_host_portion(ip_sub_map)
  network_length = ip_sub_map[:sub].count('1')
  iparray = ip_sub_map[:ip].chars
  host = iparray[network_length, 31]
end

# returns type of ip/sub address
def address_type(host_portion)
  if host_portion.include?('0') && !host_portion.include?('1')
    ipclass = 'network'
  elsif host_portion.include?('1') && !host_portion.include?('0')
 #elsif host_portion.chars.reject{ |x| x == '1' }.empty?
    ipclass = 'broadcast'
  else
    ipclass = 'host'
  end
end

def network_bits(subnet_binary)
  subnet_binary.to_s.split("").count("1").to_i
end

def host_value(subnet_binary)
   subnet_binary.to_s.split("").count("0").to_i
end

def net_valid?(subnet_binary, network_bits)
  subnet_binary.chars.slice(0, network_bits).include?('0')
end

def available_networks(network_bits)
  available_net = Array.new(network_bits, 1)
  total_networks = 0
  available_net.each_with_index do |n, i|
    total_networks += 2 ** (available_net.length-i-1) * n
  end
  total_networks
end

def host_ip_addr(host_address)
end

#TERMINAL
puts "=================================================================="
puts ""
puts "Chris' IP subnet calculator"
puts ""
puts ""
puts "Enter IP address."
ip_input = gets
puts "Enter subnet mask."
subnet_input = gets
#TERMINAL

ip_binary = to_binary_octets(ip_input)
subnet_binary = to_binary_octets(subnet_input)
#OBJECT
ip_sub_map = {ip: ip_binary , sub: subnet_binary}
# you can set function calls as values in objects
#ip_sub_map = {ip: to_binary_octets(ip_input) , sub: to_binary_octets(subnet_input)}
host_portion = binary_host_portion(ip_sub_map).join
address_type = address_type(host_portion)
host_1_count = host_portion.count('1')
host_0_count = host_portion.count('0')
network_bits = network_bits(subnet_binary)
host_value = host_value(subnet_binary)
net_valid = net_valid?(subnet_binary, network_bits)
available_networks = available_networks(network_bits)
v = net_valid ? 'WARNING: INVALID SUBNET' : "Your IP address: #{ip_input.chomp}/#{network_bits}"

#TERMINAL
puts " "
puts " "
puts "================================================================== "
puts v
puts "Address Type: #{address_type}"
puts "================================================================== "
puts "Available Networks: #{available_networks}"
puts "Subnet Prefix: /#{network_bits} prefix."
puts " "
puts " "
puts "======================BINARY CHART================================ "
puts " "
puts "IP:     " + ip_binary
puts "SUBNET: " + subnet_binary
puts " "
#TERMINAL


#net_count = network_bits.to_binary_octets.ljust(net_count_value, '0')
#host_count = host_value.to_binary_octets.ljust(host_count_value, '0')
#puts net_count
#puts host_count
