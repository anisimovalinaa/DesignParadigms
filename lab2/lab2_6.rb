def task1 l
	l[l.index(l.max)+1..]
end

def task13 l
	ind = l.index(l.min)
	# l + l[..ind-1]
	l - l[..ind-1] + l[..ind-1]
end

l = gets.split().map { |e| e.to_i }

# puts "#{task1 l}"
puts "#{task13 l}"