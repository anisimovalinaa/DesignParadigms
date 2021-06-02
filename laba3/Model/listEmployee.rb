require_relative 'employee'
require 'openssl'
require 'yaml'
require 'json'
require_relative 'db_work'

class ListEmployee
	# @@keypair = OpenSSL::PKey::RSA.new File.read('../Sources/key.pem')
	attr_accessor :list_employee
	def initialize
		self.list_employee = []
	end

	def size
		@list_employee.size
	end

	def == (list1)
		@list_employee.zip(list1).each { |el1, el2| return false if !(el1 == el2) }
		return true
	end

	def choose(num)
		@list_employee.each do |emp|
			return emp if emp.id == num
		end
	end

	def change(emp)
		DB_work.db_work.change_emp(emp)
		@list_employee = []
		read_DB
	end

	def read_list_YAML file_name
		@list_employee = YAML::load(File.open(file_name))
	end

	def write_list_YAML file_name
		File.open(file_name, 'w:UTF-8') do |file|
			file.puts(@list_employee.to_yaml)
		end
	end

	def read_list_JSON file_name
		File.open(file_name, 'r:UTF-8') do |file|
			data = JSON.parse(file.read)
			data.each do |key, value|
				if value["work_experience"] > 0
					emp = Employee.new(value["id"], value["fio"], value["datebirth"], value["phone_number"], value["address"],
														 value["e_mail"], value["passport"], value["speciality"], value["work_experience"],
														 value["last_workplace"], value["last_post"], value["last_salary"])
				else
					emp = Employee.new(value["id"], value["fio"], value["datebirth"], value["phone_number"], value["address"],
														 value["e_mail"], value["passport"], value["speciality"], value["work_experience"])
				end
			add_user(emp)
			end
		end
	end

	def write_list_JSON file_name
		File.open(file_name,"w:UTF-8") do |file|
			tempHash = {}
			@list_employee.each_with_index do |emp, ind|
				tempHash[ind] = {
					"fio": emp.fio,
					"datebirth": emp.datebirth,
					"phone_number": emp.phone_number,
					"address": emp.address,
					"e_mail": emp.e_mail,
					"passport": emp.passport,
					"speciality": emp.speciality,
					"work_experience": emp.work_experience,
					"last_workplace": emp.last_workplace,
					"last_post": emp.last_post,
					"last_salary": emp.last_salary
				}
			end
			file.write(JSON.pretty_generate(tempHash))
		end
	end

	def add_user(user)
		@list_employee << user
	end

	def to_s
		str = ""
		@list_employee.each { |user| str += user.to_s + "\n" }
		str
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
		DB_work.db_work.delete_emp(emp)
		@list_employee = []
		read_DB
	end

	def sort field
		eval "list_employee.sort! { |a, b| a.#{field} <=> b.#{field} }"
	end

	def read_DB
		@list_employee = DB_work.db_work.read_employee_list
	end
end
