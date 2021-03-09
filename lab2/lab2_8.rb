def read_list_from_file
	l = []
	File.open('file.txt') { |file| l = file.read()}
	l.split().map { |e| e.to_i }
end 

l = read_list_from_file
puts "Максимум = #{l.max}"