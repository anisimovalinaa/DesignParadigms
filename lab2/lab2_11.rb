def read_str
	str = ''
	File.open('file.txt') { |io| str = io.read().chomp }
	str
end

def task1 str
	real_digits = str.scan(/-?[\d]+\.[\d]+/)
	real_digits = real_digits.map { |el| el.to_f }
	real_digits.max
end

def task9 str
	real_digits = str.scan(/-?[\d]+\.[\d]+/)
	real_digits = real_digits.map { |el| el.to_f }
	real_digits.min
end

def task18 str
	digits = str.scan(/[\d]+/)
	digits.max { |a, b| a.size <=> b.size }.size
end

str = read_str

ans = ''

while ans != '0'
	puts 'Какое задание вы хотите решить:', '1. Дана строка. Необходимо найти максимальное из имеющихся в ней вещественных чисел.', 
	'9. Дана строка. Необходимо найти минимальное из имеющихся в ней рациональных чисел.', 
	'18. Дана строка. Необходимо найти наибольшее количество идущих подряд цифр.', 
	'0. Выйти.'

	print 'Ваш ответ: '
	ans = gets.chomp()
	case ans
	when '1'
		puts "Строка: #{str}"
		puts "Решение: #{task1 str}"
	when '9'
		puts "Строка: #{str}"
		puts "Решение: #{task9 str}"
	when '18'
		puts "Строка: #{str}"
		puts "Решение: #{task18 str}"
	when '0'
		puts 'До свидания.'
	else
		puts 'Такого пункта нет'
	end
end
puts "#{task18 str}"