require_relative 'controller_list_factory'
require_relative 'controller_employee_list'

class Controller_Employee_List_Factory < Controller_List_Factory
  def create_controller_list
    Controller_employee_list.new
  end
end