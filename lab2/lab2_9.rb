def task1 str
	alphabet = (1040..1103).to_a + [1105, 1025]
	count = 0
	str.each_char { |ch| count += 1 if alphabet.include?(ch.ord) }
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

f = File.open('file.txt')
str = f.read.chomp

puts "#{task9 str}"