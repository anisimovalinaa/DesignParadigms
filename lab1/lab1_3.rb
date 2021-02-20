puts 'Какой Ваш любимый язык программирования?'
l = gets.chomp.downcase

# if l == 'ruby' 
# 	puts 'Подлиза'
# else 
# 	puts 'Я такого не знаю'
# end
		
# if l == 'ruby'
# 	puts 'Подлиза'
# elsif l == 'c#'
# 	puts 'Не подлиза'
# elsif l == 'python'
# 	puts 'Круто'
# else 
# 	puts 'Я такого не знаю'
# end
	
puts 'Подлиза' if l == 'ruby'
