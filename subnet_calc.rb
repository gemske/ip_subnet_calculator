# this is defining the function to convert to binary from ip array
def to_binary(address_input)
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

#test for address type by comparing count of 1s and 0s in host portion. if all 1s, broadcast, if all 0s, network, otherwise host


puts ""
puts "Chris' IP subnet calculator"
puts ""
puts ""
puts "Enter IP address."
ip_input = gets
puts "Enter subnet mask."
subnet_input = gets


# this is calling the function through definition of a variable
ip_binary = to_binary(ip_input)
subnet_binary = to_binary(subnet_input)

#OBJECT
ip_sub_map = {ip: ip_binary , sub: subnet_binary}

host_portion = binary_host_portion(ip_sub_map).join
#puts host_portion.inspect

if host_portion.include?('0') && !host_portion.include?('1')
  ipclass = 'network'
elsif host_portion.include?('0') && !host_portion.include?('1')
  ipclass = 'broadcast'
else
  ipclass = 'host'
end




host_1_count = host_portion.count('1')
host_0_count = host_portion.count('0')



#puts " "
#puts "------------------------------NOTES------------------------------- "#create test for host_portion, if all 0's, display network address, all 1's broadcast, else host
#puts ip_binary
#puts subnet_binary
#puts host_portion#test for address type by comparing count of 1s and 0s in host portion. if all 1s, broadcast, if all 0s, network, otherwise host
#puts "1 count"
#puts host_1_count
#puts "0 count"
#puts host_0_count
#puts "address class"
#puts ipclass
#puts "------------------------------------------------------------------"

#array to be passed in to address_type
address_type_array = []

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
#end #alt method for below (expand)


v = net_valid ? 'WARNING: INVALID SUBNET' : "Your IP address: #{ip_input.chomp}/#{network_value}"

puts v
puts "=================================================================="
puts "There are a total of #{total_networks} networks available using a /#{net_count_value} prefix."
puts " "
puts "This is a #{ipclass} address."
puts " "

net_valid
#net_count = network_value.to_binary.ljust(net_count_value, '0')
#host_count = host_value.to_binary.ljust(host_count_value, '0')
#puts net_count
#puts host_count
