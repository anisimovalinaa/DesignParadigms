def read_str
	list_str = []
	File.open('file.txt') { |io| list_str = io.readlines() }
	list_str
end

def task list_str
	list_str.sort { |a, b| a.size <=> b.size }.reverse
end

list_str = read_str

puts "#{task list_str}"