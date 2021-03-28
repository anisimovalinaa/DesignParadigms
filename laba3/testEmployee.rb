require_relative 'employee'

class TestEmployee < Employee
	def to_s
		# puts "Имя: #{@fio}", "Дата рождения: #{@datebirth}", "Номер телефона: #{@phone_number}", 
		# "Адрес: #{@address}", "E-mail: #{@e_mail}",  "Серия и номер паспорта: #{@passport}", 
		# "Специальность: #{@specialty}", "Стаж работы по специальности: #{@work_experience}"
		# if @work_experience > 0
		# 	puts "Последнее место работы: #{@last_workplace}", "Должность: #{@last_post}", 
		# 	"Заработная плата: #{@last_salary}"
		# end
		# puts
		'Данные работника: ' + super
	end

	def self.check_correct
		puts 'Что вы хотите проверить?', '1. ФИО.', '2. Телефон.', '3. Дату.', '4. E-mail.', '5. Паспортные данные.', '0. Выйти.'
		ans = ''
		while ans != '0'
			print 'Ваш ответ: '
			ans = gets.chomp()
			case ans
			when '1'
				print 'Введите строку: '
				str = gets.chomp()
				puts convert_to_fio(str)
			when '2'
				print 'Введите строку: '
				str = gets.chomp()
				puts convert_to_number(str)
			when '3'
				print 'Введите строку: '
				str = gets.chomp()
				puts convert_to_date(str)
			when '4'
				print 'Введите строку: '
				str = gets.chomp()
				puts convert_to_email(str)
			when '5'
				print 'Введите строку: '
				str = gets.chomp()
				puts convert_to_passport(str)
			when '0'
				puts 'До свидания.'
			else
				puts 'Такого пункта нет'
			end
		end
	end
end