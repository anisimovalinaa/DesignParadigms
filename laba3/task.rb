require_relative 'employee'
require_relative 'testEmployee'
require_relative 'listEmployee'
require_relative 'terminalViewListEmployee'
require 'yaml'
require 'json'
require 'rexml/document'
require_relative 'db_work'


# emp1 = Employee.new('лапавм вк ренр', '31.08.2000', '77777777777', 'fghjk', 'vergre@gfbfbf.grt',  '5555555555', 'fgbbth', 0)
# emp = Employee.new('лапавм вк ренр', '31.08.2000', '77777777777',
#                    'fghjk', 'vergre@gfbfbf.grt',  '5555555555', 'fgbbth',
#                    4, 'fdvdc', 'fcsaz', 20)

# ObjectSpace.each_object(Employee) { |o| 
# 	puts o
# }
# TestEmployee.check_correct
# puts emp
# TerminalViewListEmployee.menu
#

con = DB_work.connection
con2 = DB_work.connection

puts con.equal?(con2)
