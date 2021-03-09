def read_str
	str = ''
	File.open('file.txt') { |io| str = io.read().chomp }
	str
end

def task1 str
	count = 0
	str.each_char { |ch| count += 1 if !(/[А-Яа-яёЁ]/ =~ ch).nil? }
	count
end

def task9 str
	str == str.reverse
	# puts str.reverse
end

def task18
	
end

str = read_str

puts "#{task9 str}"