require 'date'
require 'openssl'

class Employee
	attr_accessor :address, :speciality, :work_experience, :post
	attr_reader :fio, :datebirth, :phone_number, :e_mail, :passport
	attr_writer :last_workplace, :last_post, :last_salary
	def initialize(fio, datebirth, phone_number, address, e_mail, passport,
		speciality, work_experience, last_workplace = nil, last_post = nil,
		last_salary = nil)
		self.fio = fio
		self.datebirth = datebirth
		self.phone_number = phone_number
		self.address = address
		self.e_mail = e_mail
		self.passport = passport
		self.speciality = speciality
		self.work_experience = work_experience

		self.last_workplace = last_workplace
		self.last_post = last_post
		self.last_salary = last_salary

	end

	def ==(emp1)
		return @fio == emp1.fio && @datebirth == emp1.datebirth && @phone_number == emp1.phone_number &&
			@address == emp1.address && @e_mail == emp1.e_mail && @passport == emp1.passport &&
			@speciality == emp1.speciality && @work_experience == emp1.work_experience &&
			@last_workplace == emp1.last_workplace && @last_post == emp1.last_post && @last_salary == emp1.last_salary
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
			raise ArgumentError, "Неверная дата"
		end		
	end

	def datebirth=(x)
		begin
			@datebirth = Employee.convert_to_date(x)
		rescue ArgumentError => e
			e.message
		end
	end

	def self.passport?(x)
		digits = x.scan(/\d/)
		digits.size == 10
	end

	def self.convert_to_passport(x)
		if passport?(x)
			digits = x.scan(/\d/)
			return digits.join[0..3] + ' ' + digits.join[4...]
		else
			raise ArgumentError, "Неверные паспортные данные"
		end
	end

	def passport=(x)
		begin
			@passport = Employee.convert_to_passport(x)
		rescue ArgumentError => e
			e.message
		end		
	end

	def self.email?(x)
		ind = x =~ /[-.\w]+@([\w-]+\.)+[\w-]+$/
		ind == 0 ? true : false
	end

	def self.convert_to_email(x)
		if email?(x)
			return x.downcase
		else
			raise ArgumentError, 'Неверный e-mail'
		end
	end

	def e_mail=(x)
		begin
			@e_mail = Employee.convert_to_email(x)
		rescue ArgumentError => e
			e.message
		end
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
			raise ArgumentError, 'Неправильно введен номер телефона'
		end
	end

	def phone_number=(x)
		begin
			@phone_number = Employee.convert_to_number(x)		
		rescue ArgumentError
			'Неправильно введен номер'
		end
	end

	def self.fio?(x)
		ind = x =~ /^\s*[А-Яа-яЁё]+(?:\s*-\s*[А-Яа-яЁё]+)?\s+[А-Яа-яЁё]+(?:\s*-\s*[А-Яа-яЁё]+)?\s+[А-Яа-яЁё]+(?: [А-Яа-яЁё]+)?\s*$/
		ind == 0 ? true : false
	end

	def self.convert_to_fio(x)
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
			raise ArgumentError, 'Неверные ФИО'
		end
	end

	def fio=(x)
		begin
			@fio = Employee.convert_to_fio(x)
		rescue ArgumentError => e
			e.message
		end
	end

	def last_workplace 
		@last_workplace
	end

	def last_workplace=(x)
		@work_experience != 0 || x == nil ? @last_workplace = x :
		raise('Нет опыта работы')
	end

	def last_post
		@last_post
	end

	def last_post=(x)
		@work_experience != 0 || x == nil ? @last_post = x :
		raise('Нет опыта работы')
	end

	def last_salary
		@last_salary
	end

	def last_salary=(x)
		@work_experience != 0 || x == nil ? @last_salary = x :
		raise('Нет опыта работы')
	end

	def to_s
		if work_experience != 0
			return "#{fio}, #{datebirth}, #{phone_number}, #{address}, #{e_mail}, #{passport}, #{speciality}, #{work_experience}, #{last_workplace}, #{last_post}, #{last_salary}"
		else
			return "#{fio}, #{datebirth}, #{phone_number}, #{address}, #{e_mail}, #{passport}, #{speciality}, #{work_experience}"
		end
	end
end