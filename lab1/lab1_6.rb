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

max = max_digit ARGV[0].to_i
min = min_digit ARGV[0].to_i
mult  = mult_digits ARGV[0].to_i

print 'Максимальная цифра: ' + max.to_s + "\n"
print 'Минимальная цифра: ' + min.to_s + "\n"
print 'Произведение цифр: ' + mult.to_s + "\n"
