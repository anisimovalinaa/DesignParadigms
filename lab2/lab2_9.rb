def read_str
	str = ''
	File.open('file.txt') { |io| str = io.read() }
	str
end

def task1 str
	count = 0
	str.each_char { |ch| count += 1 if !(/[А-Яа-яёЁ]/ =~ ch).nil? }
	count
end

def task9 str
	check = true
	for i in (0..str.size/2)
		if str[i] != str[str.size-i-1]
			check = false
		end
	end
	check
end

def task18
	
end

str = read_str

puts "#{task1 str}"