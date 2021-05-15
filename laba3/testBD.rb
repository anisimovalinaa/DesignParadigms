require 'mysql2'
require_relative 'Model/employee'

client = Mysql2::Client.new(
  :host => 'localhost',
  :username => 'alina',
  :password => 'mama',
  :database => 'staff',
)

def test_select(client)
  results = client.query("SELECT * FROM employees")
  list_emp = []
  results.each do |row|
    puts row['datebirth']
    emp = Employee.new(row['FIO'], row['datebirth'].to_s, row['phone_number'], row['address'],
                       row['e_mail'], row['passport'], row['speciality'], row['work_experience'],
                       row['last_workplace'], row['last_post'], row['last_salary'])
    list_emp.append(emp)
  end
  list_emp
end

list_emp = test_select(client)
puts list_emp

# r = gets.chomp
# client.query("DELETE FROM employees WHERE passport = '#{r}'")
client.close
# list_emp.each { |emp| puts emp }
#
# y = gets
# puts "#{nil}"
