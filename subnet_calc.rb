# this is defining the function to convert to binary from ip array
def to_binary(address_input)
  address_arr = address_input.split('.')
  binary_arr = address_arr.map do |octet|     #these two lines are turning the values of the array into integers, back to strings
    octet.to_i.to_s(2).ljust(8, '0')         #of binary, and making sure there are 8 values
  end
  binary_arr.join                            #this joins the octets together into a 32 bit string
end


puts "Enter IP address."
ip_input = gets
puts "Enter subnet mask."
subnet_input = gets

# this is calling the function through definition of a variable
ip_binary = to_binary(ip_input)
subnet_binary = to_binary(subnet_input)
puts ip_binary
puts subnet_binary

#next two lines count the number of 1's (network_value) and 0's (host_value)
network_value = subnet_binary.to_s.split("").count("1")
host_value = subnet_binary.to_s.split("").count("0")
net_count_value = network_value.to_i
host_count_value = host_value.to_i

#test for valid subnet - see if needs to be network_value-1
net_valid = subnet_binary.chars.slice(0, network_value).include?('0')

available_net = Array.new(net_count_value,1)

available_net.inspect
available_net.class

total_networks = 0
available_net.each_with_index do |n, i|
  total_networks += 2**(available_net.length-i-1) * n
end

#if net_valid
#  v = 'is not'
#else
#  v = 'is'
#end

v = net_valid ? 'WARNING: INVALID SUBNET' : "Your IP address: #{ip_input.chomp}/#{network_value}"
puts v
puts "There are a total of #{total_networks} networks available using a /#{net_count_value} prefix."
net_valid
#net_count = network_value.to_binary.ljust(net_count_value, '0')
#host_count = host_value.to_binary.ljust(host_count_value, '0')
#puts net_count
#puts host_count
