class Abonent
	attr_accessor :name
	attr_reader :phone_number, :inn, :bank_account
	def initialize(inn, name, phone_number, bank_account)
		self.inn = inn
		self.name = name
		self.phone_number = phone_number
		self.bank_account = bank_account
	end

	def ==(user)
		return @inn == user.inn && @name == user.name && @phone_number == user.phone_number &&
			@bank_account == user.bank_account
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
			raise ArgumentError, "Неправильно введен номер телнфона"
		end
	end

	def phone_number=(x)
		begin
			@phone_number = Abonent.convert_to_number(x)		
		rescue ArgumentError => e
			e.message
		end
	end

	def self.inn?(x)		
		x.to_s.size == 9 ? true : false
	end

	def self.convert_to_inn(x)
		if inn?(x)
			x
		else
			raise ArgumentError, "Неправильно введен ИНН"
		end
	end

	def inn=(x)
		begin
			@inn = Abonent.convert_to_inn(x)
		rescue ArgumentError => e
			e.message
		end
	end

	def self.bank_account?(x)
		x.scan(/\d/).size == 20 ? true : false
	end

	def self.convert_to_bank_account(x)
		if bank_account?(x)
			digits = x.scan(/\d/)
			digits.join
		else
			raise ArgumentError, "Неправильно введен расчетный счет"
		end
	end

	def bank_account=(x)
		begin
			@bank_account = Abonent.convert_to_bank_account(x)		
		rescue ArgumentError => e
			e.message
		end
	end

	def to_s
		"#{inn}, #{name}, #{phone_number}, #{bank_account}"
	end
end
