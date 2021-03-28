class Abonent
	attr_accessor :name
	attr_reader :phone_number, :inn, :bank_account
	def initialize(inn, name, phone_number, bank_account)
		self.inn = inn
		self.name = name
		self.phone_number = phone_number
		self.bank_account = bank_account
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
		if phone_number?(x)
			d = all_digits(x)
			number = '7-' + d[1..3].join + '-' + d[4...].join
			return number
		else 
			raise ArgumentError
		end
	end

	def phone_number=(x)
		begin
			@phone_number = Abonent.convert_to_number(x)		
		rescue ArgumentError
			'Неправильно введен номер'
		end
	end

	def self.inn?(x)		
		x.scan(/\d/).size == 9 ? true : false
	end

	def self.convert_to_inn(x)
		if inn?(x)
			digits = x.scan(/\d/)
			digits.join
		else
			raise ArgumentError
		end
	end

	def inn=(x)
		begin
			@inn = Abonent.convert_to_inn(x)
		rescue ArgumentError
			'Неправильно введен ИНН'
		end
	end

	def bank_account=(x)
		begin
			@bank_account = Float(x)		
		rescue ArgumentError
			'Неправильно введен расчетный счет'
		end
	end

	def to_s
		"#{inn}, #{name}, #{phone_number}, #{bank_account}"
	end
end

class ListAbonent
	attr_accessor :list_abonents
	def initialize()
		self.list_abonents = []
	end

	def add_abonent(inn, name, phone_number, bank_account)		
		abonent = Abonent.new(inn, name, phone_number, bank_account)
		list_abonents << abonent
	end

	def to_s
		str = ""
		list_abonents.each { |user| str += "\n\n" + user.to_s }
		str
	end

	def read(file_name)
		File.open(file_name) do |file|
			users = file.read
			users = users.force_encoding("windows-1251")
			users = users.split("\n\n")
			users.each do |user|
				user = user.split('|')
				user.map { |el| el.force_encoding("UTF-8") }				
				list_abonents << Abonent.new(user[0], user[1], user[2], user[3])			
			end
		end
	end

	def write(file_name)
		File.open(file_name, "w") do |file|
			list_abonents.each do |user|				
				file.write(user.inn + '|' + user.name + '|' + user.phone_number + '|' +
					+ user.bank_account.to_s)				
				file.write("\n\n")
			end
		end
	end
end

class TerminalView
	@@list_abonents = ListAbonent.new

	def self.add
		puts "Введите данные:", "ИНН: "
		inn = gets.chomp
		puts "Наименование юр.лица: "
		name = gets.chomp
		puts "Номер телефона: "
		phone_number = gets.chomp
		puts "Расчетный счет в банке: "
		bank_account = gets.chomp
		@@list_abonents.add_abonent(inn, name, phone_number, bank_account)
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

	def self.menu
		read
		ans = ''
		while ans != 0
			puts "1. Добавить пользователя.", "2. Отобразить список пользователей.",  "3. Сохранить измениения в файл."
			ans = gets.chomp
			case ans
			when '1'
				add
			when '2'
				output_users			
			when '3'
				write
			when '0'
				exit
			else
				puts 'Такого пункта нет'
			end
		end
	end
end

# TerminalView.menu
ab = Abonent.new('7584621', 'lalaa', '79763452267', '54723000')
puts ab
# puts Abonents.bank_account?('77tfc786')
