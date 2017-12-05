require 'digest/md5'
require 'set'

door_id = STDIN.read.chomp

Digest::MD5.hexdigest 'abc3231929'

enum = Enumerator.new do |y|
  i = 0
  loop do
    until (digest = Digest::MD5.hexdigest("#{door_id}#{i}")).start_with?('00000')
      i = i + 1
    end
    y << digest
    i = i + 1
  end
end


#puts "Part 1:"
#puts enum.take(8).map{|str| str[5]}.join

puts "Part 2:"
password = Array.new(8)
enum.take_while do |str|
  if ('0'..'7').include?(str[5]) && password[str[5].to_i].nil?
    password[str[5].to_i] = str[6]
  end
  !password.all?
end
puts password.join

