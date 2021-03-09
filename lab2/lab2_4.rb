def method1 n
	l = []
	for i in 0..n-1
		el = $stdin.gets.to_i
		l += [el]
	end
	l
end

def method2 n
	l = []
	for i in 0..n-1
		el = $stdin.gets.to_i
		l << el
	end
	l
end

def method3 n
	l = []
	for i in 0..n-1
		el = $stdin.gets.to_i
		l.concat([el])
	end
	l
end

def method4 n
	l = []
	for i in 0..n-1
		el = $stdin.gets.to_i
		l.insert(l.size, el)
	end
	l
end

def method5 n
	l = []
	for i in 0..n-1
		el = $stdin.gets.to_i
		l[l.size] = el
	end
	l
end

def read_list_from_file path
	l = []
	File.open(path) { |file| l = file.read()}
	l = l.split().map { |e| e.to_i }
	l
end 

# l = read_list_from_file '/home/alina/Документы/file.txt'

case ARGV[1].to_i
when 1
	l = method1 ARGV[0].to_i
when 2
	l = method2 ARGV[0].to_i
when 3
	l = method3 ARGV[0].to_i
when 4
	l = method4 ARGV[0].to_i
when 5
	l = method5 ARGV[0].to_i
when 6
	l = read_list_from_file ARGV[2]
end
puts "#{l}"