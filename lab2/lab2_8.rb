def read_list_from_file
	f = File.open('file.txt')

	l = f.read()
	l.split().map { |e| e.to_i }
end 

l = read_list_from_file
puts "#Максимум = {l.max}"