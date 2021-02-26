def minimum l
	m = l[0]
	l.each { |e| m = e if e < m } 
	m
end

def maximum l
	m = l[0]
	l.each { |e| m = e if e > m } 
	m
end

def summa l
	s = 0
	l.each { |e| s += e } 
	s
end

def mult l
	m = 1
	l.each { |e| m *= e } 
	m
end

l = gets.split().map { |e| e.to_i }
puts "Минимум: #{minimum l}"
puts "Максимум: #{maximum l}"
puts "Сумма: #{summa l}"
puts "Произведение: #{mult l}"