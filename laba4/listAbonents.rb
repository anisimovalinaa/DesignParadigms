require_relative 'abonents'
require 'openssl'

class ListAbonent
	@@keypair = OpenSSL::PKey::RSA.new File.read('key.pem')
	attr_accessor :list_abonents
	def initialize()
		self.list_abonents = []
	end

	def add_abonent(abonent)		
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
				user = user.split('|||')
				user.map { |el| el.force_encoding("UTF-8") }
				user[0] = @@keypair.private_decrypt(user[0])
				add_abonent(Abonent.new(user[0], user[1], user[2], user[3]))
			end
		end
	end

	def write(file_name)
		File.open(file_name, "w") do |file|
			list_abonents.each do |user|
				encrypted_inn = @@keypair.public_encrypt(user.inn)
				file.write(encrypted_inn + '|||' + user.name + '|||' + user.phone_number + '|||' +
					+ user.bank_account.to_s)				
				file.write("\n\n")
			end
		end
	end

	def sort field
		eval "list_abonents.sort! { |a, b| a.#{field} <=> b.#{field} }"
	end

	def find_abonent(info)
		list_abonents.each do |abonent| 
			if [abonent.inn, abonent.phone_number, abonent.bank_account].include? info
				return abonent
			end
		end
		return nil
	end

	def delete(abonent)
		list_abonents.delete(abonent)
	end
end