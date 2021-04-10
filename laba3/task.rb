require_relative 'employee'
require_relative 'testEmployee'
require_relative 'listEmployee'
require_relative 'terminalViewListEmployee'
require 'yaml'
require 'json'


# emp1 = Employee.new('лапавм вк ренр', '31.08.2000', '77777777777', 'fghjk', 'vergre@gfbfbf.grt',  '5555555555', 'fgbbth', 0)
# emp = TestEmployee.new('лапавм вк ренр', '31.08.2000', '77777777777', 'fghjk', 'vergre@gfbfbf.grt',  '5555555555', 'fgbbth', 0)

# ObjectSpace.each_object(Employee) { |o| 
# 	puts o
# }
# TestEmployee.check_correct

TerminalViewListEmployee.menu

# data = YAML::load(File.open('yaml'))
# data[0].fio = 'авпрол апролд итьб'
# File.open('yaml', 'w') do |file|
#   file.puts(data.to_yaml)
# end

# data = JSON.parse(File.read("list_employee.json"))
# data.each {|key, value| puts value["fio"] }

# ff = {}
# ff[1] = {
#   "fio": "aa",
#   "string_field2": "bb"
# }
# ff[2] = {
#   "fio": "aa",
#   "string_field2": "bb"
# }
# puts ff
#
# File.open("temp.json","w") do |f|
#   f.write(JSON.pretty_generate(ff))
# end
#
# lala = {
#   "a": {
#     "fio": "aa",
#     "string_field2": "bb"
#   },
#   "b": {
#     "fio": 123,
#     "string_field4": "dd"
#   }
# }
#
# lala.each { |el|  puts el[1]["fio"] }
#

# mass = [3, 5, 1]
# mass.each_with_index do |ind, el|
#   puts ind
#   puts el
# end
