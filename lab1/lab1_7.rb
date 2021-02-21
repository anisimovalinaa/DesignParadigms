def sum_digits x
	s = 0
	while x!=0
		y = x%10
		s += y
		x /= 10
	end
end

def max_digit x
	max = x%10
	while x!=0
		if x%10 > max 
			max = x%10
		end
		x /= 10
	end
	max
end

def min_digit x
	min = x%10
	while x!=0
		if x%10 < min 
			min = x%10
		end
		x /= 10
	end
	min
end

def mult_digits x
	mult = 1
	while x!=0
		mult *= x%10
		x /= 10
	end
	mult
end

def pr x
	check = true
	for i in 2..(x-1)
		if x%i == 0
			check = false
		end
	end
	check
end

def sum_pr_del x
	s = 0
	for i in 2..x
		if pr i and x%i == 0
			s += i
		end
	end
	s
end

def method2 x
	k = 0
	while x != 0 
		if x%10 > 3 and (x%10)%2 != 0
			k += 1
		end
		x /= 10
	end
	k
end

x = ARGV[0].to_i
puts method2 x