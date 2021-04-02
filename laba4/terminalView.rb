require_relative 'abonents'
require_relative 'listAbonents'

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
			inn = gets.chomp
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

	def self.menu
		read
		# puts @@list_abonents
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
					puts "\tЧто вы хотите изменить?", "\t1. ИНН.", "\t2. Наименование юр.лица.", 
					"\t3. Номер телефона.", "\t4. Расчетный счет."
					print "\tОтвет: "
					case ans_change = gets.chomp
					when '1'
						print "\tВведите ИНН: "
						inn = try_to_convert("Abonent.convert_to_inn('#{gets.chomp}')")
						abonent.inn = inn if inn != nil
					when '2'
						print "\tВведите наименование: "
						abonent.name = gets.chomp if name != nil
					when '3'
						print "\tВведите номер телефона: "
						phone = try_to_convert("Abonent.convert_to_number('#{gets.chomp}')")
						abonent.phone_number = phone if phone != nil
					when '4'
						print "\tВведите расчетный счет: "
						bank = try_to_convert("Abonent.convert_to_bank_account('#{gets.chomp}')")
						abonent.bank_account = bank if bank != nil
					else 
						puts 'Такого пункта нет'
					end
					puts				
				end
			when '5'
				print 'Введите ИНН, номер телефона или расчетный счет: '
				data = gets.chomp
				abonent = find(data)
				if abonent.class == Abonent
					@@list_abonents.delete(abonent)
					puts "Успешно\n\n"
				end
			when '6'
				write
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
	end
end