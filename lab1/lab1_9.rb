require 'prime'

def sum_digits x
	s = 0
	while x.nonzero?
		y = x%10
		s += y
		x /= 10
	end
	s
end

def max_digit x
	max = x%10
	while x.nonzero?
		if x%10 > max 
			max = x%10
		end
		x /= 10
	end
	max
end

def min_digit x
	min = x%10
	while x.nonzero?
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

def sum_pr_del x
	list_primes = Prime.take_while { |a| a < x}
	s = 0
	for i in 2..x
		if i in list_primes and x%i == 0
			s += i
		end
	end
	s
end

def method2 x
	k = 0
	while x.nonzero? 
		if (x.remainder 10) > 3 and ((x.remainder 10).remainder 2) != 0
			k += 1
		end
		x /= 10
	end
	k
end

def method3 x
	sum_digits_x = sum_digits x
	mult = 1
	for i in 1..x
		if x%i == 0 and (sum_digits i) < sum_digits_x
			mult *= i
		end
	end
	mult
end

def h
	puts 'Первый аргумент: число', 'Второй агрумент: один из методов'
	puts 'Методы:', "\tsum_digits - сумма цифр числа", 
	"\tmax_digit - максимальная цифра числа", 
	"\tmin_digit - максимальная цифра числа", 
	"\tmult_digits - произведение цифра числа", 
	"\tsum_pr_del - сумма простых делителей числа", 
	"\tmethod2 - количество нечетных цифр числа, больших 3", 
	"\tmethod3 - прозведение таких делителей числа, сумма цифр которых меньше, чем сумма цифр исходного числа"
end

# begin
# 	m = ARGV[1] + ' ' + ARGV[0]
# 	puts eval m
# rescue SyntaxError => e
# 	h
# rescue 
# 	h
# end

puts method2 5555899
puts 56.div 10