require 'prime'

def sum_digits x
	x.digits.sum
end

def max_digit x
	x.digits.max
end

def min_digit x
	x.digits.min
end

def mult_digits x
	x.digits.reduce(:*)
end

def sum_pr_del x
	list_primes = Prime.take_while { |a| a <= x}
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
	digits = x.digits
	digits.each { |digit| k += 1 if digit > 3 and (digit.remainder 2) != 0}
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
	puts 'Методы:', "\t1. sum_digits - сумма цифр числа", 
	"\t2. max_digit - максимальная цифра числа", 
	"\t3. min_digit - максимальная цифра числа", 
	"\t4. mult_digits - произведение цифра числа", 
	"\t5. sum_pr_del - сумма простых делителей числа", 
	"\t6. method2 - количество нечетных цифр числа, больших 3", 
	"\t7. method3 - прозведение таких делителей числа, сумма цифр которых меньше, чем сумма цифр исходного числа"
end

begin
	raise if ARGV.size == 0
	ARGV.each_with_index do |met, ind|
		if ind != 0
			case met
			when '1'
				m = 'sum_digits ' + ARGV[0]
				puts "Сумма цифр = #{eval m}"
			when '2'
				m = 'max_digit ' + ARGV[0]
				puts "Максимальная цифра = #{eval m}"
			when '3'
				m = 'min_digit ' + ARGV[0]
				puts "Минимальная цифра = #{eval m}"
			when '4'
				m = 'mult_digits ' + ARGV[0]
				puts "Призведение цифр = #{eval m}"
			when '5'
				m = 'sum_pr_del ' + ARGV[0]
				puts "Сумма простых делителей = #{eval m}"
			when '6'
				m = 'method2 ' + ARGV[0]
				puts "Количество нечетных цифр числа, больших 3 = #{eval m}"
			when '7'
				m = 'method3 ' + ARGV[0]
				puts "Прозведение делителей числа, сумма цифр которых меньше, чем сумма цифр исходного числа = #{eval m}"
			else
				raise
			end
		end
	end
rescue SyntaxError => e
	h
rescue 
	h
end
