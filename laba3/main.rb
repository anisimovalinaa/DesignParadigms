require_relative 'controller_department_list_factory'
require_relative 'controller_employee_list_factory'

class Main
  def self.main
    controller_emp = Controller_Employee_List_Factory.new
    controller_list = controller_emp.create_controller_list
    controller_list.show_view
  end
end

if $0 == __FILE__
  Main.main
end