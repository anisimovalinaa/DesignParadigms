require_relative 'Controller/controller_department_list_factory'
require_relative 'Controller/controller_employee_list_factory'
require_relative 'View/terminal_view_department_list'

class Main
  def self.main
    controller_dep = Controller_Department_List_Factory.new
    controller_list = controller_dep.create_controller_list
    view = Terminal_view_department_list.new(controller_list)
    # view.show

    controller_emp = Controller_Employee_List_Factory.new
    controller_emp = controller_emp.create_controller_list
    view_emp = Terminal_view_list_employee.new(controller_emp)
    view_emp.show
  end
end

if $0 == __FILE__
  Main.main
end