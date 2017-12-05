#!/usr/bin/env ruby

require 'digest/md5'

seed = STDIN.read.chomp

x = 1

until Digest::MD5.hexdigest("#{seed}#{x}").start_with?('00000')
  x += 1
end

puts x
