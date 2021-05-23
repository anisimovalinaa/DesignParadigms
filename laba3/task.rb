require_relative 'Model/employee'
require_relative 'testEmployee'
require_relative 'Model/listEmployee'
require_relative 'View/terminalViewListEmployee'
require 'yaml'
require 'json'
require 'rexml/document'
require_relative 'Model/db_work'
require_relative 'Model/department'
require_relative 'Model/post_list'
require_relative 'Model/department_list'
require_relative 'View/terminal_view_department_list'
require_relative 'Controller/controller_list'
require_relative 'Controller/controller_department_list'


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

# department_list = Department_list.new
# department_list.read_DB
#
# terminal = Terminal_view_department_list.new(department_list)
# terminal.show #

# emp_list = ListEmployee.new
# emp_list.read_DB
# view_emp = Terminal_view_list_employee.new(emp_list)
#
# view_emp.show
#

controller = Controller_department_list.new
controller.show_view