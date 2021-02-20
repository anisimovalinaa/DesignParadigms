puts 'Какой Ваш любимый язык программирования?'
l = gets.chomp.downcase

# if l == 'ruby' 
# 	puts 'Подлиза'
# else 
# 	puts 'А скоро будет ruby'
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
	
# puts 'Подлиза' if l == 'ruby'

# x = if l == 'ruby' then puts 'Подлиза' else puts 'А скоро будет ruby' end

unless l != 'ruby'
	puts 'Подлиза'
end
