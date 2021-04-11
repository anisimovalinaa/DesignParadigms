require_relative 'abonents'
require_relative 'listAbonents'
require_relative 'work_with_DB'

class TerminalView
	@@list_abonents = ListAbonent.new()

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
			puts "Введите данные:"
			print "ИНН: "
			inn = gets.chomp.to_i
			print "Наименование юр.лица: "
			name = gets.chomp
			print "Номер телефона: "
			phone_number = gets.chomp
			print "Расчетный счет в банке: "
			bank_account = gets.chomp

			inn = try_to_convert("Abonent.convert_to_inn('#{inn}')")
			phone_number = try_to_convert("Abonent.convert_to_number('#{phone_number}')")
			bank_account = try_to_convert("Abonent.convert_to_bank_account('#{bank_account}')")

			if not [inn, phone_number, bank_account].include? nil
				@@list_abonents.add_abonent(Abonent.new(inn, name, phone_number, bank_account))
				@@connection.add_to_DB(Abonent.new(inn, name, phone_number, bank_account))
				check = false
				puts 'Успешно'
			end
		end
	end

	def self.read
		@@list_abonents.read("listAbonents.txt")
	end

	def self.write
		@@list_abonents.write("listAbonents.txt")
	end

	def self.output_users
		puts @@list_abonents
	end

	def self.find(data)
		abonent = @@list_abonents.find_abonent(data)
		if abonent == nil
			puts 'Неверные данные'
		else
			abonent
		end
	end

	def self.compare_data(list1, list2)
		return false if list1.size != list2.size
		return list1 == list2
	end

	def self.try_connect
		begin
			list_serialized = ListAbonent.new()
			list_serialized.read_list_YAML 'list_abonents.yaml'

			@@connection = WorkWithDB.new(@@list_abonents)
			@@connection.read_list_DB

			check = compare_data(@@list_abonents, list_serialized)
			if check == false
				ans = ''
				while ans != '0'
					puts 'Записи в базе данных и в сериализованном файле не совпадают. Какой вариант вам предпочтительнее?',
							 '1. Данные из БД', '2. Данные из файла'
					print 'Ответ: '
					ans = gets.chomp
					case ans
					when '1'
						@@list_abonents.write_list_YAML 'list_abonents.yaml'
						puts 'Работаем с БД'
						ans = '0'
					when '2'
						@@list_abonents = list_serialized
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
					@@list_abonents.read_list_YAML 'list_abonents.yaml'
				when '2'
					exit
				else
					puts 'Такого пункта нет'
				end
			end
		end
	end


	def self.menu
		try_connect
		# @@connection.read_list_DB
		# @@list_abonents.read_list_YAML 'list_abonents.yaml'
		# @@list_abonents.read_list_JSON 'list_abonents.json'
		ans = ''
		while ans != 0
			puts "**********Меню**********", "1. Добавить пользователя.", 
			"2. Отобразить список пользователей.", "3. Найти абонента.", 
			'4. Изменить абонента.', '5. Удалить абонента',
			"6. Сохранить изменения в файл.", '7. Сортировать по конкретному полю.', 
			"0. Выход."
			print 'Ответ: '
			ans = gets.chomp
			case ans
			when '1'
				puts
				add
				puts
			when '2'
				output_users
				puts		
			when '3'
				print 'Введите ИНН, номер телефона или расчетный счет: '
				data = gets.chomp
				puts find(data)
				puts
			when '4'
				print 'Введите ИНН, номер телефона или расчетный счет: '
				data = gets.chomp
				abonent = find(data)
				if abonent.class == Abonent
					puts "\tЧто вы хотите изменить?", "\t1. Наименование юр.лица.",
					"\t2. Номер телефона.", "\t3. Расчетный счет."
					print "\tОтвет: "
					ans_change = gets.chomp
					case ans_change
					when '1'
						print "\tВведите наименование: "
						abonent.name = gets.chomp if name != nil
					when '2'
						print "\tВведите номер телефона: "
						phone = try_to_convert("Abonent.convert_to_number('#{gets.chomp}')")
						abonent.phone_number = phone if phone != nil
					when '3'
						print "\tВведите расчетный счет: "
						bank = try_to_convert("Abonent.convert_to_bank_account('#{gets.chomp}')")
						abonent.bank_account = bank if bank != nil
					else 
						puts 'Такого пункта нет'
					end
					@@connection.change_node(abonent)
					puts				
				end
			when '5'
				print 'Введите ИНН, номер телефона или расчетный счет: '
				data = gets.chomp
				abonent = find(data)
				if abonent.class == Abonent
					@@list_abonents.delete(abonent)
					@@connection.delete_from_db(abonent)
					puts "Успешно\n\n"
				end
			when '6'
				@@list_abonents.write_list_YAML 'list_abonents.yaml'
				@@list_abonents.write_list_JSON 'list_abonents.json'
				puts
			when '7'
				puts "\tПо каким полям вы хотите отсортировать?", "\t1. ИНН.", "\t2. Наименование юр.лица.",
					"\t3. Телефон.", "\t4. Расчетный счет."
				print "\tОтвет: "
				ans_sort = gets.chomp.split()
				ans_sort.each { |field|
					case field
					when '1'
						@@list_abonents.sort 'inn'
					when '2'
						@@list_abonents.sort 'name'
					when '3'
						@@list_abonents.sort 'phone_number'
					when '4'
						@@list_abonents.sort 'bank_account'
					else
						puts "\tТакого пункта нет"
					end
				}
				puts
			when '0'
				exit
			else
				puts 'Такого пункта нет'
			end
		end
		@@connection.close
	end
end