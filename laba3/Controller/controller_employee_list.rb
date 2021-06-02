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

  def change_instance(fio, datebirth, phone_number, address, e_mail, passport,
                      speciality, work_experience, last_workplace, last_post,
                      last_salary)
    if @instance == nil
      raise ArgumentError
    else
      @instance.fio = fio
      @instance.datebirth = datebirth
      @instance.phone_number = phone_number
      @instance.address = address
      @instance.e_mail = e_mail
      @instance.passport = passport
      @instance.speciality = speciality
      @instance.work_experience = work_experience
      if work_experience > 0
        @instance.last_workplace = last_workplace
        @instance.last_post = last_post
        @instance.last_salary = last_salary
      end
      @list.change(@instance)
    end
  end

  def delete_instance
    if @instance == nil
      raise ArgumentError
    else
      @list.delete(@instance)
      @instance = nil
    end
  end

end