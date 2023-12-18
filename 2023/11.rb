data = STDIN.readlines.map(&:chars)

require 'set'

expanded_rows = (0...data.size).select{|row| row.uniq == ['.']}.to_set
expanded_cols = (0...data.first.size).map{|row| row[i]}.select{|col| col.uniq == ['.']}.to_set

