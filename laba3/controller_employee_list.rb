require_relative 'terminalViewListEmployee'
require_relative 'listEmployee'
require_relative 'controller_list'

class Controller_employee_list < Controller_list
  public_class_method :new

  def initialize
    @list = ListEmployee.new
    @list.read_DB
    @view_list = Terminal_view_list_employee.new(@list)
  end
end