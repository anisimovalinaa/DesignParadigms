require_relative '../View/terminalViewListEmployee'
require_relative '../Model/listEmployee'
require_relative 'controller_list'

class Controller_employee_list < Controller_list
  public_class_method :new
  attr_accessor :instance

  def initialize
    @list = ListEmployee.new
    @list.read_DB
    @view_list = Terminal_view_list_employee.new(self)
  end

  def show_list
    @list
  end

  def add(fio, datebirth, phone_number, address, e_mail, passport,
          speciality, work_experience, last_workplace = nil, last_post = nil,
          last_salary = nil)

    emp = Employee(nil, fio, datebirth, phone_number, address, e_mail, passport,
                   speciality, work_experience, last_workplace = nil, last_post = nil,
                   last_salary = nil)
  end

  def choose_instance(num)
    @instance = @list.choose(num)
  end
end