def task1 l
	l[l.index(l.max)+1..]
end

l = gets.split().map { |e| e.to_i }

puts "#{task1 l}"