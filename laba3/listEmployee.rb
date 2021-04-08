require_relative 'employee'
require 'openssl'

class ListEmployee
	@@keypair = OpenSSL::PKey::RSA.new File.read('key.pem')
	attr_accessor :list_employee
	def initialize(connection = nil)
		self.list_employee = []
		read_list_DB(connection) if connection != nil
		list_employee
	end

	def read_list_DB(connection)
		results = connection.query("SELECT * FROM employees")
		results.each do |row|
			data = row['datebirth'].to_s.split('-').reverse.join('.')
			emp = Employee.new(row['FIO'], data, row['phone_number'], row['address'],
												 row['e_mail'], row['passport'], row['speciality'], row['work_experience'],
												 row['last_workplace'], row['last_post'], row['last_salary'])
			add_user(emp)
		end
	end

	def add_to_DB(connnection, user)
		connnection.query("INSERT INTO `staff`.`employees` (`FIO`, `datebirth`, `phone_number`, `address`, `e_mail`,
													`passport`, `speciality`, `work_experience`, `last_workplace`, `last_post`, `last_salary`)
											VALUES (#{user.fio}, #{user.datebirth}, #{user.phone_number}, #{user.address}, #{user.e_mail},
															#{user.passport}, #{user.speciality}, #{user.work_experience}, #{user.last_workplace},
															#{user.last_post}, #{user.last_salary});")
	end

	def change_node(connection, emp)
		date = emp.datebirth.to_s.split('.').reverse.join('-')
		connection.query("UPDATE employees SET FIO = '#{emp.fio}', datebirth = '#{date}',
										phone_number = '#{emp.phone_number}', address = '#{emp.address}',
										e_mail = '#{emp.e_mail}', passport = '#{emp.passport}', speciality = '#{emp.speciality}',
										work_experience = '#{emp.work_experience}', last_workplace = '#{emp.last_workplace}',
										last_post = '#{emp.last_post}', last_salary = '#{emp.last_salary}'
										WHERE passport = '#{emp.passport}'")
	end

	def delete_from_db(connection, emp)
		connection.query("DELETE FROM employees WHERE passport = '#{emp.passport}'")
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
				user = user.split('|||')
				user.map { |el| el.force_encoding("UTF-8") }
				user[5] = @@keypair.private_decrypt(user[5])
				if user[7].to_i > 0
					add_user(Employee.new(user[0], user[1], user[2], user[3], 
						user[4], user[5], user[6], user[7].to_i, user[8], user[9], user[10]))
				else
					add_user(Employee.new(user[0], user[1], user[2], user[3], 
						user[4], user[5], user[6], user[7].to_i))
				end
			end
		end
	end

	def write_file(file_name)
		File.open(file_name, "w") do |file|
			list_employee.each do |user|
				passport_sifr = @@keypair.public_encrypt(user.passport)
				file.write(user.fio + '|||' + user.datebirth + '|||' + user.phone_number + '|||' +
					+ user.address + '|||' + user.e_mail + '|||' + passport_sifr.force_encoding('UTF-8') +
					+ '|||' + user.specialty + '|||' + user.work_experience.to_s)
				if user.work_experience > 0 
					file.write('|||' + user.last_workplace + '|||' + user.last_post + '|||' + user.last_salary)
				end
				file.write("\n\n")
			end
		end
	end

	def find_emp(info)
		list_employee.each do |emp|
			if [emp.fio, emp.e_mail, emp.phone_number, emp.passport].include? info
				return emp
			end
		end
		return nil
	end

	def each(&block)
		@list_employee.each { |user| block.call(user) }
	end

	def delete(emp)
		list_employee.delete(emp)
	end

	def sort field
		eval "list_employee.sort! { |a, b| a.#{field} <=> b.#{field} }"
	end
end
