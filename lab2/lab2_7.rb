require 'prime'

def task1 l
	ind = l.reverse.find_index { |i| i == l.max}
	l.reverse[...ind].size
end

def task13 l
	ind = l.index(l.min)
	l += l[...ind]
	l[ind..]
end

def task25(l, a, b)
	l[a..b].max
end

def task37 l
	ind = []
	l.map.with_index { |e, i|  ind += [i] if i > 0 and e < l[i-1]}
	return ind, ind.size
end

def task49 l
	list_pr_del = []
	l.map { |el| list_pr_del += Prime.take_while { 
		|a| a <= el}.reject { |e| el%e != 0 } }
	list_pr_del.uniq().sort()
end

puts 'Введите список:'
l = gets.split().map { |e| e.to_i }

ans = ''

while ans != '0'
	puts 'Какое задание вы хотите решить:', '1. Дан целочисленный массив. Необходимо найти количество
элементов, расположенных после последнего максимального.', '13. Дан целочисленный массив. Необходимо разместить элементы,
расположенные до минимального, в конце массива.', '25. Дан целочисленный массив и интервал a..b. Необходимо найти
максимальный из элементов в этом интервале.', '37. Дан целочисленный массив. Вывести индексы элементов, которые
меньше своего левого соседа, и количество таких чисел.', '49. Для введенного списка положительных чисел построить список всех
положительных простых делителей элементов списка без повторений.', '0. Выйти.'

	print 'Ваш ответ: '
	ans = gets.chomp()
	case ans
	when '1'
		puts "Список: #{l}"
		puts "Решение: #{task1 l}"
	when '13'
		puts "Список: #{l}"
		puts "Решение: #{task13 l}"
	when '25'
		puts 'Необходимо ввести интервал'
		print 'a = '
		a = gets.to_i
		print 'b = '
		b = gets.to_i
		puts "Список: #{l}"
		puts "Решение: #{task25(l, a, b)}"
	when '37'
		list_ind, count = task37 l
		puts "Список: #{l}"
		puts "Решение: #{list_ind} - индексы, #{count} - количество элементов"
	when '49'
		puts "Список: #{l}"
		puts "Решение: #{task49 l}"
	when '0'
		puts 'До свидания.'
		
	else
		puts 'Такого пункта нет'
	end
end