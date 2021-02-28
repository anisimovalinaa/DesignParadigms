def task1 str
	alphabet = (1040..1103).to_a + [1105, 1025]
	count = 0
	str.each_char { |ch| count += 1 if alphabet.include?(ch.ord) }
	count
end

f = File.open('file.txt')
str = f.read

puts "#{task1 str}"