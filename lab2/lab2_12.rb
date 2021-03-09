def read_str
	list_str = []
	File.open('file.txt') { |io| list_str = io.readlines() }
	list_str
end

def task12 list_str
	list_str.sort { |a, b| a.size <=> b.size }.reverse
end

def task13 list_str
	list_str.sort { |a, b| a.split.size <=> b.split.size }
end

def task14 list_str
	list_str.sort { |a, b| a.scan(/(?:[\d]) (?:[A-Za-zА-Яа-яЁё]+)/).size 
		<=> b.scan(/(?:[\d]) (?:[A-Za-zА-Яа-яЁё]+)/).size }
end

list_str = read_str

puts "#{task14 list_str}"