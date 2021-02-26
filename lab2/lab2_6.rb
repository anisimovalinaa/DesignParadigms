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
	l += l[..ind-1]
	for i in 0..ind-1
		l.delete_at(0)
	end
	l
end

def task25(l, a, b)
	l[a..b].max
end

l = gets.split().map { |e| e.to_i }

puts "#{task25(l, 2, 4)}"

# puts "Ответ: #{eval 'task13 l'}"

