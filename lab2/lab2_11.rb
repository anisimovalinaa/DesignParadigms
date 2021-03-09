def read_str
	str = ''
	File.open('file.txt') { |io| str = io.read().chomp }
	str
end

def task1 str
	real_digits = str.scan(/-?[\d]+\.[\d]+/)
	real_digits = real_digits.map { |el| el.to_f }
	real_digits.max
end

def task9 str
	real_digits = str.scan(/-?[\d]+\.[\d]+/)
	real_digits = real_digits.map { |el| el.to_f }
	real_digits.min
end

str = read_str

puts "#{task9 str}"