def read_str
	str = ''
	File.open('file.txt') { |io| str = io.read().chomp }
	str
end

def task1 str
	count = 0
	str.each_char { |ch| count += 1 if !(/[А-Яа-яёЁ]/ =~ ch).nil? }
	count
end

def task9 str
	str == str.reverse
end

def task18 str
	str.scan(/\s[0-3]?[\d]\.[0-1][\d]\.[\d]{1,4}\s?/)
end

str = read_str

ans = ''

while ans != '0'
	puts 'Какое задание вы хотите решить:', '1. Дана строка. Необходимо найти общее количество русских символов.', '9. Дана строка. Необходимо проверить образуют ли строчные
символы латиницы палиндром.', '18. Найти в тексте даты формата «день.месяц.год».', '0. Выйти.'

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
		puts "Список: #{str}"
		puts "Решение: #{task18 str}"
	when '0'
		puts 'До свидания.'
	else
		puts 'Такого пункта нет'
	end
end