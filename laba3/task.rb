class Employee
	attr_accessor :name, :datebirth, :phone_number, :address, :e_mail, 
	:passport, :specialty, :work_experience
	def initialize(name, datebirth, phone_number, address, e_mail, passport,
		specialty, work_experience, last_workplace = nil, last_post = nil,
		last_salary = nil)
		@name = name
		@datebirth = datebirth
		@phone_number = phone_number
		@address = address
		@e_mail = e_mail
		@specialty = specialty
		@work_experience = work_experience
		@last_workplace = last_workplace
		@last_post = last_post
		@last_salary = last_salary
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

	def last_workplace=(x)
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

emp.last_workplace = 'fdvd'
puts emp.last_post
