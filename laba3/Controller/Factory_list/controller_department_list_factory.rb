require_relative 'controller_list_factory'
require_relative '../controller_department_list'

class Controller_Department_List_Factory < Controller_List_Factory
  def create_controller_list
    Controller_department_list.new
  end
end