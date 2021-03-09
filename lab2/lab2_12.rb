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

list_str = read_str

puts "#{task13 list_str}"