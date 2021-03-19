require 'date'
require 'openssl'

class Employee
	attr_accessor :address, :specialty, :work_experience
	attr_reader :fio, :datebirth, :phone_number, :e_mail, :passport
	attr_writer :last_workplace, :last_post, :last_salary
	def initialize(fio, datebirth, phone_number, address, e_mail, passport,
		specialty, work_experience, last_workplace = nil, last_post = nil,
		last_salary = nil)
		self.fio = fio
		self.datebirth = datebirth
		self.phone_number = phone_number
		self.address = address
		self.e_mail = e_mail
		self.passport = passport
		self.specialty = specialty
		self.work_experience = work_experience
		if work_experience != '0'
			@last_workplace = last_workplace
			@last_post = last_post
			@last_salary = last_salary
		end
	end

	def Employee.date?(x)
		begin
			DateTime.strptime(x, '%d.%m.%Y')
			return true
		rescue Date::Error
			return false
		end
	end

	def Employee.convert_to_date(x)
		begin
			if Employee.date?(x)
				date = DateTime.strptime(x, '%d.%m.%Y')
				day = date.day.to_s
				month = date.month.to_s
				year = date.year.to_s
				day = '0' + day if day.size == 1
				month = '0' + month if month.size == 1
				year = '20' + year if year.size == 2
				return day + '.' + month + '.' + year
			else 
				raise RuntimeError
			end
		rescue RuntimeError
			puts 'Неверная дата'
		end
	end

	def datebirth=(x)
		@datebirth = Employee.convert_to_date(x)
	end

	def Employee.passport?(x)
		digits = x.scan(/\d/)
		digits.size == 10
	end

	def Employee.convert_to_passport(x)
		begin
			if Employee.passport?(x)
				digits = x.scan(/\d/)
				return digits.join[0..3] + ' ' + digits.join[4...]
			else
				raise RuntimeError
			end
		rescue RuntimeError
			puts 'Неверно введены паспортные данные'
		end
	end

	def passport=(x)
		@passport = Employee.convert_to_passport(x)
	end

	def Employee.email?(x)
		ind = x =~ /[-.\w]+@([\w-]+\.)+[\w-]+$/
		ind == 0 ? true : false
	end

	def Employee.convert_to_email(x)
		begin
			if Employee.email?(x)
				return x.downcase
			else
				raise RuntimeError
			end
		rescue RuntimeError
			puts 'Неправильный e-mail'
		end
	end

	def e_mail=(x)
		@e_mail = Employee.convert_to_email(x)
	end

	def Employee.all_digits(x)
		digits = x.scan(/^(8|\+?7)/)
		if digits.size > 0
			digits += x[digits[0][0].size..].scan(/\d/)
		end
		digits
	end

	def Employee.phone_number?(x)
		Employee.all_digits(x).size == 11
	end

	def Employee.convert_to_number(x)
		begin
			if Employee.phone_number?(x)
				d = Employee.all_digits(x)
				number = '7-' + d[1..3].join + '-' + d[4...].join
				return number
			else 
				raise RuntimeError
			end
		rescue RuntimeError
			puts 'Неправильно введен номер телефона'
		end
	end

	def phone_number=(x)
		@phone_number = Employee.convert_to_number(x)
	end

	def Employee.fio?(x)
		ind = x =~ /^\s*[А-Яа-яЁё]+(?:\s*-\s*[А-Яа-яЁё]+)?\s+[А-Яа-яЁё]+(?:\s*-\s*[А-Яа-яЁё]+)?\s+[А-Яа-яЁё]+(?: [А-Яа-яЁё]+)?\s*$/
		ind == 0 ? true : false
	end

	def Employee.convert_to_fio(x)
		begin
			if Employee.fio?(x)
				x.strip!
				res = ''
				word = ''
				x.each_char do |ch|
					if ch != '-'
						word += ch
					else
						word = word.split()
						word.each { |el| el.capitalize!}
						res += word.join(' ') + ch
						word = ''
					end
				end

				word = word.split()
				res += word.join(' ')
				return res
			else
				raise RuntimeError
			end
		rescue RuntimeError
			puts 'Неверные ФИО'
		end
	end

	def fio=(x)
		@fio = Employee.convert_to_fio(x)
	end

	def last_workplace 
		@last_workplace == nil ? puts('Значение отсутствует') : @last_workplace
	end

	def last_workplace=(x)
		@work_experience != 0 ? @last_workplace = x : 
		puts('Нет опыта работы')
	end

	def last_post
		@last_post == nil ? puts('Значение отсутствует') : @last_post
	end

	def last_post=(x)
		@work_experience != 0 ? @last_post = x : 
		puts('Нет опыта работы')
	end

	def last_salary
		@last_salary == nil ? puts('Значение отсутствует') : @last_salary
	end

	def last_salary=(x)
		@work_experience != 0 ? @last_salary = x : 
		puts('Нет опыта работы')
	end
end

class TestEmployee < Employee
	def to_s
		puts "Имя: #{@fio}", "Дата рождения: #{@datebirth}", "Номер телефона: #{@phone_number}", 
		"Адрес: #{@address}", "E-mail: #{@e_mail}",  "Серия и номер паспорта: #{@passport}", 
		"Специальность: #{@specialty}", "Стаж работы по специальности: #{@work_experience}"
		if @work_experience > 0
			puts "Последнее место работы: #{@last_workplace}", "Должность: #{@last_post}", 
			"Заработная плата: #{@last_salary}"
		end
	end

	def TestEmployee.check_correct
		puts 'Что вы хотите ввести?', '1. ФИО.', '2. Телефон.', '3. Дату.', '4. E-mail.', '0. Выйти.'
		ans = ''
		while ans != '0'
			print 'Ваш ответ: '
			ans = gets.chomp()
			case ans
			when '1'
				print 'Введите строку: '
				str = gets.chomp()
				puts TestEmployee.convert_to_fio(str)
			when '2'
				print 'Введите строку: '
				str = gets.chomp()
				puts TestEmployee.convert_to_number(str)
			when '3'
				print 'Введите строку: '
				str = gets.chomp()
				puts TestEmployee.convert_to_date(str)
			when '4'
				print 'Введите строку: '
				str = gets.chomp()
				puts TestEmployee.convert_to_email(str)
			when '0'
				puts 'До свидания.'
			else
				puts 'Такого пункта нет'
			end
		end
	end
end

class TerminalViewListEmployee
	@@list_employee = []
	@@keypair = OpenSSL::PKey::RSA.new File.read('key.pem')

	def TerminalViewListEmployee.check_nil(user)
		user.fio == nil or user.datebirth == nil or user.passport == nil or 
			user.phone_number == nil or user.e_mail == nil
	end

	def TerminalViewListEmployee.input_data
		ans = ''
		while ans != '0'
			puts '1. Добавить запись.', '0. Выход.'
			print 'Ваш ответ: '
			ans = gets.chomp
			case ans
			when '1'
				check = true
				while check
					puts 'Введите данные'
					print 'ФИО: '
					fio = gets.chomp
					print 'Дата рождения: '
					daybirth = gets.chomp
					print 'Телефон: '
					phone = gets.chomp
					print 'Адрес: '
					addres = gets.chomp
					print 'E-mail: '
					e_mail = gets.chomp
					print 'Паспорт: '
					passport = gets.chomp
					print 'Специальность: '
					specialty = gets.chomp
					print 'Опыт работы: '
					work_experience = gets.chomp
					if work_experience.to_i > 0
						print 'Последнее место работы: '
						last_workplace = gets.chomp
						print 'Должность: '
						last_post = gets.chomp
						print 'Заработная плата: '
						last_salary = gets.chomp
					end
					user = Employee.new(fio, daybirth, phone, addres, e_mail, passport, 
						specialty, work_experience, last_workplace, last_post, last_salary)
					check = TerminalViewListEmployee.check_nil(user)
					@@list_employee << user if !check
					puts 'Успешно' if !check
					puts
				end
			when '0'
				puts 'До свидания'
			else
				puts 'Нет такого пункта'
			end
		end
	end

	def TerminalViewListEmployee.output_data
		puts "#{@@list_employee}"
	end

	def TerminalViewListEmployee.write_file
		File.open("list_employee.txt", "a") do |file|
			data = ['Алина паа вавва', '23.08.2000', '79999443762', 'Адрес', 'my@mail.ru']
			data << @@keypair.public_encrypt('3950 472188')
			data += ['Специальность', '0']
			file.write(data[0] + ',' + data[1] + ',' + data[2] + ',' + data[3] + ',' + 
				+ data[4] + ',' + data[5].force_encoding("UTF-8") + ',' + data[6] + ',' + data[7] + "\n\n")
		end
	end

	def TerminalViewListEmployee.read_file
		File.open("list_employee.txt") do |file|
			users = file.read
			users = users.force_encoding("windows-1251")
			users = users.split("\n\n")
			users.each do |user|
				user = user.split(',')
				user.map { |el| el.force_encoding("UTF-8") }
				data_passport = @@keypair.private_decrypt(user[5])
				@@list_employee << Employee.new(user[0], user[1], user[2], user[3], user[4], data_passport, user[6], user[7])
			end
		end
	end
end

emp1 = TestEmployee.new('    АнисиМОва-Иванова Алина-Малина   Александровна заде  ', '63.08.2000', '+79996975019', 'lala', 
	'aLina@gma@il.com', '7565928384', 'lala', 0)

emp2 = TestEmployee.new('Бабина Наталья Алексеевна', '4.05.1994', '89186628610', 'lala', 'my@mail.ru', 
	'8493 223510', 'lala', 5, 'Место работы', 'Должность', 'з/п')

# TerminalViewListEmployee.input_data
# TerminalViewListEmployee.write_file
TerminalViewListEmployee.read_file
TerminalViewListEmployee.output_data