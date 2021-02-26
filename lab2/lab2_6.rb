def task1 l
	ind = 0
	for i in 0..l.size
		if l[i] == l.max
			ind = i
		end
	end
	l[ind+1...].size
end

def task13 l
	ind = l.index(l.min)
	l + l[..ind-1]
	# l - l[..ind-1]
end

l = gets.split().map { |e| e.to_i }

puts "#{task1 l}"

# puts "Ответ: #{eval 'task13 l'}"

