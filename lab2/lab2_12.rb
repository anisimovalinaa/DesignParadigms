def read_str
	list_str = []
	File.open('file.txt') { |io| list_str = io.readlines() }
	list_str
end

def task12 list_str
	list_str.sort { |a, b| a.size <=> b.size }.reverse
end

def task13 list_str
	list_str.sort { |a, b| a.split.size <=> b.split.size }
end

def task14 list_str
	list_str.sort { |a, b| a.scan(/(?:[\d]) (?:[A-Za-zА-Яа-яЁё]+)/).size <=> b.scan(/(?:[\d]) (?:[A-Za-zА-Яа-яЁё]+)/).size }
end

#номер 15
def mean_count_letters(str, letters)
	list_words = str.split()
	count = 0
	letters == 'vowel' ?
		list_words.each { |word| count += word.scan(/a|e|i|o|u|y/).size } :
		list_words.each { |word| count += word.scan(/b|c|d|f|g|h|j|k|l|m|n|p|q|r|s|t|v|w|x|z/).size }
	count.to_f/list_words.size.to_f
end

def difference str
	(mean_count_letters(str, 'consonant') - mean_count_letters(str, 'vowel')).abs
end

def task1 list_str
	list_str.sort { |a, b| difference(a) <=> difference(b) }
end

def pair_count_difference str
	count_con_vow = str.scan(/(?:б|в|г|д|ж|з|к|л|м|н|п|р|с|т|ф|х|ц|ч|ш|щ){1}(?:а|е|ё|и|о|у|э|ю|я){1}/).size
	count_vow_con = str.scan(/(?:а|е|ё|и|о|у|э|ю|я){1}(?:б|в|г|д|ж|з|к|л|м|н|п|р|с|т|ф|х|ц|ч|ш|щ){1}/).size
	count_con_vow - count_vow_con
end

def task7 list_str
	list_str.sort { |a, b| pair_count_difference(a) <=> pair_count_difference(b) }
end

def count_trio str
	count = 0
	str.each_char.each_cons(3) do |a|
		troika = a.join
		count += 1 if troika == troika.reverse
	end
	count
end

def task10 list_str
	list_str.sort { |a, b| count_trio(a) <=> count_trio(b) }
end

list_str = read_str

ans = ''

while ans != '0'
	puts 'Какое задание вы хотите решить:', '12. Прочитать список строк из файла. Упорядочить по длине
строки.', '13. Дан список строк из файла. Упорядочить по количеству слов в строке.', 
'14. Дан список строк из файла.Упорядочить по количеству слов идущих после 
чисел.', '1. В порядке увеличения разницы между средним количеством со-
гласных и средним количеством гласных букв в строке', '7. В порядке увеличения разницы между количеством сочетаний
«гласная-согласная» и «согласная-гласная» в строке', '10. В порядке увеличения среднего количества «зеркальных» троек
(например, «ada») символов в строке', '0. Выйти.'

	print 'Ваш ответ: '
	ans = gets.chomp()
	case ans
	when '12'
		puts "\nСтрока: #{list_str}"
		puts "Решение: #{task12 list_str}"
	when '13'
		puts "\nСтрока: #{list_str}"
		puts "Решение: #{task13 list_str}"
	when '14'
		puts "\nСтрока: #{list_str}"
		puts "Решение: #{task14 list_str}"
	when '1'
		puts "\nСтрока: #{list_str}"
		puts "Решение: #{task1 list_str}"
	when '7'
		puts "\nСтрока: #{list_str}"
		puts "Решение: #{task7 list_str}"
	when '10'
		puts "\nСтрока: #{list_str}"
		puts "Решение: #{task10 list_str}"
	when '0'
		puts 'До свидания.'
	else
		puts 'Такого пункта нет'
	end
	puts
end