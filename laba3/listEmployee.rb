require_relative 'employee'

class ListEmployee
	attr_accessor :list_employee
	def initialize()
		self.list_employee = []
	end

	def add_user(user)
		@list_employee << user
	end

	def to_s
		str = ""
		list_employee.each { |user| str += "\n\n" + user.to_s }
		str
	end

	def each(&block)
		@list_employee.each { |user| block.call(user) }
	end

	def find_by_fio fio_str
		found_items = []
		list_employee.each { |user| found_items << user if user.fio == fio_str }
		found_items
	end

	def find_by_passport(e_mail_str, phone_str, passport_str)
		found_items = []
		list_employee.each { |user| found_items << user if user.e_mail == e_mail_str && 
			user.phone_number == phone_str && user.passport == passport_str }
		found_items
	end

	def find_by_phone phone_str
		list_employee.each { |user| return user if user.phone_number == phone_str }
	end

	def sort pole
		eval "list_employee.sort! { |a, b| a.#{pole} <=> b.#{pole} }"
	end
end
