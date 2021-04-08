require_relative 'employee'
require_relative 'testEmployee'
require_relative 'listEmployee'
require_relative 'terminalViewListEmployee'


# emp1 = Employee.new('лапавм вк ренр', '31.08.2000', '77777777777', 'fghjk', 'vergre@gfbfbf.grt',  '5555555555', 'fgbbth', 0)
# emp = TestEmployee.new('лапавм вк ренр', '31.08.2000', '77777777777', 'fghjk', 'vergre@gfbfbf.grt',  '5555555555', 'fgbbth', 0)

# ObjectSpace.each_object(Employee) { |o| 
# 	puts o
# }
# TestEmployee.check_correct

TerminalViewListEmployee.menu
# TestEmployee.check_correct

# puts 'прнгно'