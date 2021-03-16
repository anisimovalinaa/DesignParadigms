class Employee
	attr_accessor :name, :datebirth, :address, :e_mail, 
	:passport, :specialty, :work_experience
	attr_reader :phone_number
	def initialize(name, datebirth, phone_number, address, e_mail, passport,
		specialty, work_experience, last_workplace = nil, last_post = nil,
		last_salary = nil)
		self.name = name
		self.datebirth = datebirth
		self.phone_number = phone_number
		self.address = address
		self.e_mail = e_mail
		self.specialty = specialty
		self.work_experience = work_experience
		if work_experience != '0'
			@last_workplace = last_workplace
			@last_post = last_post
			@last_salary = last_salary
		end
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
		if Employee.phone_number?(x)
			d = Employee.all_digits(x)
			number = '7-' + d[1..3].join + '-' + d[4...].join
			return number
		else 
			raise 'Nogggg'
		end
	end

	def phone_number=(x)
		@phone_number = Employee.convert_to_number(x)
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

emp = Employee.new('Alina', '23.08.2000', '+79996975019', 'lala', 
	'alina@gmail.com', '7565 928384', 'lala', 0)

puts emp.phone_number
