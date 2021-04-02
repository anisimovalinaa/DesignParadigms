require_relative 'employee'

class TestEmployee < Employee
	def to_s
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
				begin
					puts convert_to_fio(str)
				rescue ArgumentError => e
					puts e.message
				end
			when '2'
				print 'Введите строку: '
				str = gets.chomp()
				begin
					puts convert_to_number(str)
				rescue ArgumentError => e
					puts e.message
				end
			when '3'
				print 'Введите строку: '
				str = gets.chomp()
				begin
					puts convert_to_date(str)
				rescue ArgumentError => e
					puts e.message
				end
			when '4'
				print 'Введите строку: '
				str = gets.chomp()
				begin
					puts convert_to_email(str)
				rescue ArgumentError => e
					puts e.message
				end
			when '5'
				print 'Введите строку: '
				str = gets.chomp()
				begin
					puts convert_to_passport(str)
				rescue ArgumentError => e
					puts e.message
				end
			when '0'
				puts 'До свидания.'
			else
				puts 'Такого пункта нет'
			end
		end
	end
end