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

l = method1 ARGV[0].to_i
puts "#{l}"