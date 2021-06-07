require 'date'
require 'openssl'

# Класс для хранения информации о сотруднике
# :title:Employee
class Employee
	attr_accessor :address, :speciality, :work_experience, :post, :id
	attr_reader :fio, :datebirth, :phone_number, :e_mail, :passport
	attr_writer :last_workplace, :last_post, :last_salary

	# Метод класса +new+ инициализирует класс
	# === Parameters
	# * _id_ - номер сотрудника
	# * _fio_ - ФИО
	# * _datebirth_ - дата рождения
	# * _phone_number_ - номер телефона
	# * _address_ - адрес
	# * _e_mail_ - e-mail
	# * _passport_ - серия и номер паспорта
	# * _speciality_ - специальность
	# * _work_experience_ - опыт работы
	# * _last_workplace_ - прошлое место работы
	# * _last_post_ - прошлая должность
	# * _last_salary_ - прошлая зарплата
	def initialize(id, fio, datebirth, phone_number, address, e_mail, passport,
		speciality, work_experience, last_workplace = nil, last_post = nil,
		last_salary = nil)
		self.id = id
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

	# Метод объекта +==+ сравнивает поля объекта с полями другого объекта
	# ===Parameters
	# * _emp_
	def ==(emp)
		return @fio == emp1.fio && @datebirth == emp1.datebirth && @phone_number == emp1.phone_number &&
			@address == emp1.address && @e_mail == emp1.e_mail && @passport == emp1.passport &&
			@speciality == emp1.speciality && @work_experience == emp1.work_experience &&
			@last_workplace == emp1.last_workplace && @last_post == emp1.last_post && @last_salary == emp1.last_salary
	end

	# Метод класса +date?+. Возвращает +true+, если строка является датой
	# === Parameters
	# * _x_ - строка для проверки
	# === Example
	# Employee.date?('21.04.2021') # => true
	def self.date?(x)
		begin
			DateTime.strptime(x, '%d.%m.%Y')
			return true
		rescue Date::Error
			return false
		end
	end

	# Метод класса +convert_to_date+. Если проверяемая строка явялется датой, возвращает ее в виде dd.mm.YY
	# === Parameters
	# * _x_ - строка для конвертации
	# === Example
	# Employee.convert_to_date('9.3.2012') # => '09.03.2012'
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

	# Метод объекта +datebirth=+. Сеттер +datebirth+
	# === Parameters
	# * _x_
	def datebirth=(x)
		begin
			@datebirth = Employee.convert_to_date(x)
		rescue ArgumentError => e
			e.message
		end
	end

	# Метод класса +passport?+. Возвращает +true+, если строка является паспортными данными
	# === Parameters
	# * _x_ - строка для проверки
	# === Example
	# Employee.passport?('2665488219') # => true
	def self.passport?(x)
		digits = x.scan(/\d/)
		digits.size == 10
	end

	# Метод класса +convert_to_passport+. Если проверяемая строка явялется паспортными данными, возвращает ее в виде 'dddd dddddd'
	# === Parameters
	# * _x_ - строка для конвертации
	# === Example
	# Employee.convert_to_passport('0000000000') # => '0000 000000'
	def self.convert_to_passport(x)
		if passport?(x)
			digits = x.scan(/\d/)
			return digits.join[0..3] + ' ' + digits.join[4...]
		else
			raise ArgumentError, "Неверные паспортные данные"
		end
	end

	# Метод объекта +passport=+. Сеттер +passport+
	# === Parameters
	# * _x_
	def passport=(x)
		begin
			@passport = Employee.convert_to_passport(x)
		rescue ArgumentError => e
			e.message
		end		
	end

	# Метод класса +email?+. Возвращает +true+, если строка является e-mail
	# === Parameters
	# * _x_ - строка для проверки
	# === Example
	# Employee.email?('ivan@mail.com') # => true
	def self.email?(x)
		ind = x =~ /[-.\w]+@([\w-]+\.)+[\w-]+$/
		ind == 0 ? true : false
	end

	# Метод класса +convert_to_email+. Если проверяемая строка явялется e-mail, переводит ее в нижний регистр
	# === Parameters
	# * _x_ - строка для конвертации
	# === Example
	# Employee.convert_to_email('Ivan@MAIL.ru') # => 'ivan@mail.ru'
	def self.convert_to_email(x)
		if email?(x)
			return x.downcase
		else
			raise ArgumentError, 'Неверный e-mail'
		end
	end

	# Метод объекта +e_mail=+. Сеттер +e_mail+
	# === Parameters
	# * _x_
	def e_mail=(x)
		begin
			@e_mail = Employee.convert_to_email(x)
		rescue ArgumentError => e
			e.message
		end
	end

	# Метод класса +all_digits+. Возвращает массив всех чисел их строки
	# === Parameters
	# * _x_ - строка
	# === Example
	# Employee.all_digits('aaa53aaa117a3') #=> ['5', '3', '1', '1', '7', '3']
	def self.all_digits(x)
		digits = x.scan(/^(8|\+?7)/)
		if digits.size > 0
			digits += x[digits[0][0].size..].scan(/\d/)
		end
		digits
	end

	# Метод класса +phone_number?+. Возвращает +true+, если строка является номером телефона
	# === Parameters
	# * _x_ - строка для проверки
	# === Example
	# Employee.phone_number?('+79990000000') # => true
	def self.phone_number?(x)
		all_digits(x).size == 11
	end

	# Метод класса +convert_to_number+. Если проверяемая строка явялется номером телефона, возвращает ее в виде '7-ddd-ddddddd'
	# === Parameters
	# * _x_ - строка для конвертации
	# === Example
	# Employee.convert_to_email('8800000000000') # => '7-800-0000000'
	def self.convert_to_number(x)
		if phone_number?(x)
			d = all_digits(x)
			number = '7-' + d[1..3].join + '-' + d[4...].join
			return number
		else 
			raise ArgumentError, 'Неправильно введен номер телефона'
		end
	end

	# Метод класса +phone_number=+. Сеттер +phone_number+
	# === Parameters
	# * _x_
	def phone_number=(x)
		begin
			@phone_number = Employee.convert_to_number(x)		
		rescue ArgumentError
			'Неправильно введен номер'
		end
	end

	# Метод класса +fio?+. Возвращает +true+, если строка является ФИО
	# === Parameters
	# * _x_ - строка для проверки
	# === Example
	# Employee.fio?('Иванов Иван Иванович') # => true
	def self.fio?(x)
		ind = x =~ /^\s*[А-Яа-яЁё]+(?:\s*-\s*[А-Яа-яЁё]+)?\s+[А-Яа-яЁё]+(?:\s*-\s*[А-Яа-яЁё]+)?\s+[А-Яа-яЁё]+(?: [А-Яа-яЁё]+)?\s*$/
		ind == 0 ? true : false
	end

	# Метод класса +convert_to_fio+. Если проверяемая строка явялется ФИО, переводит первую букву компонент в верхний регистр
	# === Parameters
	# * _x_ - строка для конвертации
	# === Example
	# Employee.convert_to_email('иванов иван иванович') # => 'Иванов Иван Иванович'
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

	# Метод объекта +fio=+. Сеттер +fio+
	# === Parameters
	# * _x_
	def fio=(x)
		begin
			@fio = Employee.convert_to_fio(x)
		rescue ArgumentError => e
			e.message
		end
	end

	# Метод объекта +last_workplace=+. Сеттер +last_workplace+
	# === Parameters
	# * _x_
	def last_workplace=(x)
		@work_experience != 0 || x == nil ? @last_workplace = x :
		raise('Нет опыта работы')
	end

	# Метод объекта +last_post=+. Сеттер +last_post+
	# === Parameters
	# * _x_
	def last_post=(x)
		@work_experience != 0 || x == nil ? @last_post = x :
		raise('Нет опыта работы')
	end

	# Метод объекта +last_salary=+. Сеттер +last_salary+
	# === Parameters
	# * _x_
	def last_salary=(x)
		@work_experience != 0 || x == nil ? @last_salary = x :
		raise('Нет опыта работы')
	end

	# Метод объекта +to_s+. Возрвращает объект в строковом представлении
	def to_s
		if work_experience != 0
			return "#{id}, #{fio}, #{datebirth}, #{phone_number}, #{address}, #{e_mail}, #{passport}, #{speciality}, #{work_experience}, #{last_workplace}, #{last_post}, #{last_salary}"
		else
			return "#{id}, #{fio}, #{datebirth}, #{phone_number}, #{address}, #{e_mail}, #{passport}, #{speciality}, #{work_experience}"
		end
	end
end