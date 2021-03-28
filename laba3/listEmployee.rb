require_relative 'employee'
require 'openssl'

class ListEmployee
	@@keypair = OpenSSL::PKey::RSA.new File.read('key.pem')
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

	def read_file(file_name)
		File.open(file_name) do |file|
			users = file.read
			users = users.force_encoding("windows-1251")
			users = users.split("\n\n")
			users.each do |user|
				user = user.split('|')
				user.map { |el| el.force_encoding("UTF-8") }
				data_passport = @@keypair.private_decrypt(user[5])
				if user[7].to_i > 0
					list_employee << Employee.new(user[0], user[1], user[2], user[3], 
						user[4], data_passport, user[6], user[7].to_i, user[8], user[9], user[10])
				else
					list_employee << Employee.new(user[0], user[1], user[2], user[3], 
						user[4], data_passport, user[6], user[7].to_i)
				end
			end
		end
	end

	def write_file(file_name)
		File.open(file_name, "w") do |file|
			list_employee.each do |user|
				passport_sifr = @@keypair.public_encrypt(user.passport)
				file.write(user.fio + '|' + user.datebirth + '|' + user.phone_number + '|' +
					+ user.address + '|' + user.e_mail + '|' + passport_sifr.force_encoding("UTF-8") + 
					+ '|' + user.specialty + '|' + user.work_experience.to_s)
				if user.work_experience > 0 
					file.write('|' + user.last_workplace + '|' + user.last_post + '|' + user.last_salary) 
				end
				file.write("\n\n")
			end
		end
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

	def sort_by_fio
		list_employee.sort! { |a, b| a.fio <=> b.fio }
	end

	def sort_by_datebirth
		list_employee.sort! { |a, b| a.datebirth <=> b.datebirth }
	end

	def sort_by_phone
		list_employee.sort! { |a, b| a.phone_number <=> b.phone_number }
	end

	def sort_by_email
		list_employee.sort! { |a, b| a.e_mail <=> b.e_mail }
	end

	def sort_by_passport
		list_employee.sort! { |a, b| a.passport <=> b.passport }
	end

	def sort_by_work_experience
		list_employee.sort! { |a, b| a.work_experience <=> b.work_experience }
	end

	def sort_by_speciality
		list_employee.sort! { |a, b| a.specialty <=> b.specialty }
	end
end
