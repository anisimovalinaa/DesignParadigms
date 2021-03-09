def read_list_from_file
	l = []
	File.open('file.txt') { |file| l = file.read()}
	l = l.split().map { |e| e.to_i }
	l
end 

l = read_list_from_file
puts l