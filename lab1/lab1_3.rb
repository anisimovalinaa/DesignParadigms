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

# unless l != 'ruby'
# 	puts 'Подлиза'
# end

# unless l != 'ruby'
# 	puts 'Подлиза'
# else
# 	puts 'А скоро будет ruby'
# end

# puts 'Подлиза' unless l != 'ruby'

# x = unless l != 'ruby' then puts 'Подлиза' 
# 	else puts 'А скоро будет ruby' end

# case l
# when 'ruby'
# 	puts 'Подлиза'
# when 'c#'
# 	puts 'Не подлиза'
# when 'python'
# 	puts 'Круто'
# when 'f#'
# 	puts 'А скоро будет ruby'
# else
# 	puts 'Я такого не знаю'
# end

l == 'ruby' ? puts('Подлиза') : puts('А я такого не знаю')