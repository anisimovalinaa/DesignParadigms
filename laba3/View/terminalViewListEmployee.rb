require_relative '../Model/listEmployee'
require_relative '../Model/employee'
require_relative '../work_with_DB'
require 'openssl'
require 'mysql2'
require_relative 'terminal_view_list'

if (Gem.win_platform?)
	Encoding.default_external = Encoding.find(Encoding.locale_charmap)
	Encoding.default_internal = __ENCODING__

	[STDIN, STDOUT].each do |io|
		io.set_encoding(Encoding.default_external, Encoding.default_internal)
	end
end

class Terminal_view_list_employee < Terminal_view_list
	@@keypair = OpenSSL::PKey::RSA.new File.read('key.pem')
	# @@list_employee = ListEmployee.new

	def try_to_convert(str)
		begin
			eval str
		rescue ArgumentError => e
			puts e.message
		end
	end

	def add
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
				if work_experience.to_i > 0
					user = Employee.new(fio, daybirth, phone, address, e_mail, passport,
					specialty, work_experience.to_i, last_workplace, last_post, last_salary)
				else
					user = Employee.new(fio, daybirth, phone, address, e_mail, passport,
															specialty, work_experience.to_i)
				end
				@list.add_user(user)
				@@connection.add_to_DB(user)
				check = false
				puts 'Успешно'
			end
			puts
		end
	end

	def show_list
		puts @list
	end

	def find(data)
		emp = @list.find_emp(data)
		if emp.class != Employee
			puts 'Неверные данные'
		else
			emp
		end
	end

	def compare_data(list1, list2)
		return false if list1.size != list2.size
		return list1 == list2
	end

	def self.try_connect
		begin
			list_serialized = ListEmployee.new()
			list_serialized.read_list_YAML 'list_employee.yaml'

			@@connection = WorkWithDB.new(@@list_employee)
			@@connection.read_list_DB

			check = compare_data(@@list_employee, list_serialized)
			if check == false
				ans = ''
				while ans != '0'
					puts 'Записи в базе данных и в сериализованном файле не совпадают. Какой вариант вам предпочтительнее?',
							 '1. Данные из БД', '2. Данные из файла'
					print 'Ответ: '
					ans = gets.chomp
					case ans
					when '1'
						@@list_employee.write_list_YAML 'list_employee.yaml'
						puts 'Работаем с БД'
						ans = '0'
					when '2'
						@@list_employee = list_serialized
						@@connection.update_DB(list_serialized)
						puts 'Работаем с файлом'
						ans = '0'
					else
						puts 'Такого пункта нет'
					end
				end
			end
		rescue Mysql2::Error
			ans = ''
			while ans != '1'
				puts 'Подключение к базе невозможно.', '1. Прочитать данные из сериализованного файла.', '2. Завершить работу.'
				print 'Ответ: '
				ans = gets.chomp
				case ans
				when '1'
					@@list_employee.read_list_YAML 'list_employee.yaml'
				when '2'
					exit
				else
					puts 'Такого пункта нет'
				end
			end
		end
	end

	def close
		exit
	end

	def show
		# try_connect

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
				show_list
				puts
			when '3'
				print 'Введите ФИО, номер телефона, паспортные данные или e-mail: '
				data = gets.chomp
				puts find(data)
				puts
			when '4'
				print 'Введите ФИО, номер телефона, паспортные данные или e-mail: '
				data = gets.chomp
				person = find(data)
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
						fio = try_to_convert("Employee.convert_to_fio('#{gets.chomp}')")
						person.fio = fio if fio != nil
					when '2'
						print "\tВведите дату рождения: "
						date = try_to_convert("Employee.convert_to_date('#{gets.chomp}')")
						person.datebirth = date if date != nil
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
					WorkWithDB.connection.change_node(person)
				end
			when '5'
				print 'Введите ФИО, номер телефона, паспортные данные или e-mail: '
				data = gets.chomp
				person = find(data)

				if person.class == Employee
					@list.delete(person)
					WorkWithDB.connection.delete_from_db(person)
					puts "Успешно\n\n"
				end
			when '6'
				# @@list_employee.write_file("list_employee.txt")
				@list.write_list_JSON 'list_employee.json'
				@list.write_list_YAML 'list_employee.yaml'
				puts "Успешно\n\n"
			when '7'
				puts "\tПо каким полям вы хотите отсортировать?", "\t1. ФИО.", "\t2. Дата рождения.",
					"\t3. Телефон.", "\t4. E-mail.", "\t5. Паспорт.", 
					"\t6. Специальность.", "\t7. Опыт работы."
				print "\tОтвет: "
				ans_sort = gets.chomp.split()
				ans_sort.each { |field|
					case field
					when '1'
						@list.sort 'fio'
					when '2'
						@list.sort 'datebirth'
					when '3'
						@list.sort 'phone_number'
					when '4'
						@list.sort 'e_mail'
					when '5'
						@list.sort 'passport'
					when '6'
						@list.sort 'specialty'
					when '7'
						@list.sort 'work_experience'
					else
						puts "\tТакого пункта нет"
					end
				}
				puts
			when '0'
				close
			else
				puts 'Такого пункта нет'
			end
		end
	end
end
