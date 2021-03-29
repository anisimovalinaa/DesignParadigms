require_relative 'listEmployee'
require_relative 'employee'
require 'openssl'

class TerminalViewListEmployee
	@@keypair = OpenSSL::PKey::RSA.new File.read('key.pem')
	@@list_employee = ListEmployee.new()

	def self.try_to_convert(str)
		begin
			eval str
		rescue ArgumentError => e
			puts e.message
		end
	end

	def self.add
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
			address = gets.chomp
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

			fio = try_to_convert("Employee.convert_to_fio('#{fio}')")
			daybirth = try_to_convert("Employee.convert_to_date('#{daybirth}')")
			phone = try_to_convert("Employee.convert_to_number('#{phone}')")
			e_mail = try_to_convert("Employee.convert_to_email('#{e_mail}')")
			passport = try_to_convert("Employee.convert_to_passport('#{passport}')")

			if not([fio, daybirth, phone, e_mail, passport].include? nil)
				user = Employee.new(fio, daybirth, phone, address, e_mail, passport, 
				specialty, work_experience.to_i, last_workplace, last_post, last_salary)
				@@list_employee.add_user(user)
				check = false
				puts 'Успешно'
			end		
			puts
		end
	end

	def self.output_users
		puts @@list_employee
	end

	def self.menu
		@@list_employee.read_file("list_employee.txt")
		ans = ''
		while ans != '0'
			puts "--------Меню-------", '1. Добавить нового пользователя.', 
			'2. Отобразить список пользователей', '3. Найти пользователя по введенным данным.', 
			'4. Изменить конкретного пользователя.', '5. Удалить пользователя.', 
			'6. Сохранить изменения в файл.', '7. Сортировать по конкретному полю.', '0. Закрыть программу.'
			print 'Ответ: '
			ans = gets.chomp
			case ans
			when '1'
				puts
				add
			when '2'
				output_users
				puts
			when '3'
				puts "\t1. По ФИО.", "\t2. По e-mail, телефону и  паспортным данным."
				print "\tОтвет: "
				ans_find = gets.chomp
				case ans_find
				when '1'
					print "\tВведите ФИО: "	
					list_items = @@list_employee.find_by_fio gets.chomp
					puts
					list_items.each { |el| el.get_info}
				when '2'
					print "\tВведите e_mail: "
					email = gets.chomp
					print "\tВведите телефон: "
					tel = gets.chomp
					print "\tВведите серию и номер паспорта: "
					pas = gets.chomp
					list_items = @@list_employee.find_by_passport(email, tel, pas)
					puts
					list_items.each { |el| el.get_info}
				else 
					puts 'Такого пункта нет'
				end
			when '4'
				print "\tВведите номер телефона: "
				person = @@list_employee.find_by_phone gets.chomp
				if person.class == Employee
					puts "\tЧто вы хотите изменить?", "\t1. ФИО.", "\t2. Дату рождения.", 
					"\t3. Адрес.", "\t4. Специальность.", "\t5. Опыт работы.", 
					"\t6. Предыдущее место работы.", "\t7. Предыдущая должность.", 
					"\t8. Предыдущая зарплата."
					print "\tОтвет: "
					ans_change = gets.chomp
					case ans_change
					when '1'
						print "\tВведите ФИО: "
						person.fio = gets.chomp
					when '2'
						print "\tВведите дату рождения: "
						person.datebirth = gets.chomp
					when '3'
						print "\tВведите адрес: "
						person.address = gets.chomp
					when '4'
						print "\tВведите специальность: "
						person.specialty = gets.chomp
					when '5'
						print "\tВведите опыт работы: "
						person.work_experience = gets.chomp.to_i
					when '6'
						print "\tВведите последнее место работы: "
						person.last_workplace = gets.chomp
					when '7'
						print "\tВведите предыдущую должность: "
						person.last_post = gets.chomp
					when '8'
						print "\tВведите предыдущую зарплату: "
						person.last_salary = gets.chomp
					else 
						puts 'Такого пункта нет'
					end
					puts
				else
					puts "\tПользователя с таким номером телефона нет\n\n"
				end
			when '5'
				print "\tВведите номер телефона: "
				person = @@list_employee.find_by_phone gets.chomp
				if person.class == TestEmployee
					@@list_employee.delete(person)
					puts "\tУспешно\n\n"
				else
					puts "\tПользователя с таким номером телефона нет\n\n"
				end
			when '6'
				@@list_employee.write_file("list_employee.txt")
				puts "Успешно\n\n"
			when '7'
				puts "\tПо какому полю вы хотите отсортировать?", "\t1. ФИО.", "\t2. Дата рождения.", 
					"\t3. Телефон.", "\t4. E-mail.", "\t5. Паспорт.", 
					"\t6. Специальность.", "\t7. Опыт работы."
				print "\tОтвет: "
				ans_sort = gets.chomp
				case ans_sort
				when '1'
					@@list_employee.sort 'fio'
				when '2'
					@@list_employee.sort 'datebirth'
				when '3'
					@@list_employee.sort 'phone_number'
				when '4'
					@@list_employee.sort 'e_mail'
				when '5'
					@@list_employee.sort 'passport'
				when '6'
					@@list_employee.sort 'specialty'
				when '7'
					@@list_employee.sort 'work_experience'
				else
					puts "\tТакого пункта нет"
				end
				puts
			when '0'
				exit
			else
				puts 'Такого пункта нет'
			end
		end
	end
end
