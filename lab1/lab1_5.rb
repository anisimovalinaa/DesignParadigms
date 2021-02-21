x = ARGV[0].to_i

s = 0

while x!=0
	y = x%10
	s += y
	x /= 10
end

puts "Сумма цифр числа = #{s}"