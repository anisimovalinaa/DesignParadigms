def minimum l
	l.min
end

def maximum l
	l.max
end

def summa l
	l.sum
end

def mult l
	l.reduce(:*)
end

l = gets.split().map { |e| e.to_i }
puts minimum l
puts maximum l
puts summa l
puts mult l