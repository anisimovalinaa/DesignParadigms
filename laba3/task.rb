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

	def self.date?(x)
		begin
			DateTime.strptime(x, '%d.%m.%Y')
			return true
		rescue Date::Error
			return false
		end
	end

	def self.convert_to_date(x)
		begin
			if date?(x)
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

	def self.passport?(x)
		digits = x.scan(/\d/)
		digits.size == 10
	end

	def self.convert_to_passport(x)
		begin
			if passport?(x)
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

	def self.email?(x)
		ind = x =~ /[-.\w]+@([\w-]+\.)+[\w-]+$/
		ind == 0 ? true : false
	end

	def self.convert_to_email(x)
		begin
			if email?(x)
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

	def self.all_digits(x)
		digits = x.scan(/^(8|\+?7)/)
		if digits.size > 0
			digits += x[digits[0][0].size..].scan(/\d/)
		end
		digits
	end

	def self.phone_number?(x)
		all_digits(x).size == 11
	end

	def self.convert_to_number(x)
		begin
			if phone_number?(x)
				d = all_digits(x)
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

	def self.fio?(x)
		ind = x =~ /^\s*[А-Яа-яЁё]+(?:\s*-\s*[А-Яа-яЁё]+)?\s+[А-Яа-яЁё]+(?:\s*-\s*[А-Яа-яЁё]+)?\s+[А-Яа-яЁё]+(?: [А-Яа-яЁё]+)?\s*$/
		ind == 0 ? true : false
	end

	def self.convert_to_fio(x)
		begin
			if fio?(x)
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
				word.each { |el| el.capitalize!}
				res += word.join(' ')
				res = res.split()
				if res.size == 4
					res[3].downcase!
				end
				return res.join(' ')
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

	def get_info
		puts "#{@fio}, #{@datebirth}, #{@phone_number}, #{@address}, #{@e_mail}, #{@passport}, #{@specialty}, #{@work_experience}, #{@last_workplace}, #{@last_post}, #{@last_salary}"
	end
end

class TestEmployee < Employee
	def get_info
		puts "Имя: #{@fio}", "Дата рождения: #{@datebirth}", "Номер телефона: #{@phone_number}", 
		"Адрес: #{@address}", "E-mail: #{@e_mail}",  "Серия и номер паспорта: #{@passport}", 
		"Специальность: #{@specialty}", "Стаж работы по специальности: #{@work_experience}"
		if @work_experience > 0
			puts "Последнее место работы: #{@last_workplace}", "Должность: #{@last_post}", 
			"Заработная плата: #{@last_salary}"
		end
		puts
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


class ListEmployee
	@@list_employee = []
	@@keypair = OpenSSL::PKey::RSA.new File.read('key.pem')

	def self.check_nil(user)
		user.fio == nil or user.datebirth == nil or user.passport == nil or 
			user.phone_number == nil or user.e_mail == nil
	end

	def self.add_user
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
			user = TestEmployee.new(fio, daybirth, phone, addres, e_mail, passport, 
				specialty, work_experience.to_i, last_workplace, last_post, last_salary)
			check = check_nil(user)
			@@list_employee << user if !check
			puts 'Успешно' if !check
			puts
		end
	end

	def self.output_data
		@@list_employee.each { |user| puts user.get_info}
	end

	def self.read_file
		File.open("list_employee.txt") do |file|
			users = file.read
			users = users.force_encoding("windows-1251")
			users = users.split("\n\n")
			users.each do |user|
				user = user.split(',')
				user.map { |el| el.force_encoding("UTF-8") }
				data_passport = @@keypair.private_decrypt(user[5])
				if user[7].to_i > 0
					@@list_employee << TestEmployee.new(user[0], user[1], user[2], user[3], 
						user[4], data_passport, user[6], user[7].to_i, user[8], user[9], user[10])
				else
					@@list_employee << TestEmployee.new(user[0], user[1], user[2], user[3], 
						user[4], data_passport, user[6], user[7].to_i)
				end
			end
		end
	end

	def self.find_by_fio fio_str
		found_items = []
		@@list_employee.each { |user| found_items << user if user.fio == fio_str }
		found_items
	end
end

class TerminalViewListEmployee < ListEmployee
	def self.input_data
		ans = ''
		while ans != '0'
			puts '1. Добавить запись.', '0. Выход.'
			print 'Ваш ответ: '
			ans = gets.chomp
			case ans
			when '1'
				add_user
			when '0'
				exit
			else
				puts 'Нет такого пункта'
			end
		end
	end

	def self.write_file
		File.open("list_employee.txt", "a") do |file|
			@@list_employee.each do |user|
				passport_sifr = @@keypair.public_encrypt(user.passport)
				file.write(user.fio + ',' + user.datebirth + ',' + user.phone_number + ',' +
					+ user.address + ',' + user.e_mail + ',' + passport_sifr.force_encoding("UTF-8") + 
					+ ',' + user.specialty + ',' + user.work_experience.to_s)
				if user.work_experience > 0 
					file.write(',' + user.last_workplace + ',' + user.last_post + ',' + user.last_salary) 
				end
				file.write("\n\n")
			end
		end
	end

	def self.menu
		ans = ''
		while ans != '0'
			puts "--------Меню-------", '1. Добавить нового пользователя.', 
			'2. Отобразить список пользователей', '0. Закрыть программу.'
			print 'Ответ: '
			ans = gets.chomp
			case ans
			when '1'
				puts
				add_user
			when '2'
				puts
				output_data
			when '3'
				read_file
			when '4'
				el = gets.chomp
				list_items = find_by_fio el
				list_items.each { |el| el.get_info}
			when '0'
				exit
			else
				puts 'Такого пункта нет'
			end	
		end
	end
end


# emp1 = Employee.new('лапавм вк ренр', '31.08.2000', '77777777777', 'fghjk', 'vergre@gfbfbf.grt',  '5555555555', 'fgbbth', 0)
# emp = TestEmployee.new('лапавм вк ренр', '31.08.2000', '77777777777', 'fghjk', 'vergre@gfbfbf.grt',  '5555555555', 'fgbbth', 0)

# ObjectSpace.each_object(Employee) { |o| 
# 	o.get_info
# }

# TestEmployee.check_correct
# TerminalViewListEmployee.input_data
# TerminalViewListEmployee.write_file
# TerminalViewListEmployee.read_file
# TerminalViewListEmployee.output_data

TerminalViewListEmployee.menu

# ListEmployee.add_user
# ListEmployee.output_data

# екпкп рнере укаук
# 23.08.2000
# 76665548943
# ываолд
# ffrefe@gvfg.gf
# 9936523175
# dyul
# 0