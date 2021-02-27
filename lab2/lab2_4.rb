def read_list_from_file
	f = File.open('file.txt')

	l = f.read()
	l = l.split().map { |e| e.to_i }
	l
end 

l = read_list_from_file
puts l