require_relative 'employee'
require_relative 'testEmployee'
require_relative 'listEmployee'
require_relative 'terminalViewListEmployee'
require 'yaml'
require 'json'
require 'rexml/document'
require_relative 'db_work'
require_relative 'department'
require_relative 'post_list'
require_relative 'department_list'


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

# dep = Department.new('Лала')
# dep.read_DB
# post_list = Post_list.new()
# post_list.read_DB
# dep.post_list = post_list
# dep_list = Department_list.new
# # dep_list.read_DB
#
# dep_list.read_list_YAML
#
# dep_list.write_list_YAML
#
d1 = DB_work.new
