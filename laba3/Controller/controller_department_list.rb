require_relative 'controller_list'
require_relative 'controller_department_instance'
require_relative '../View/terminal_view_department_list'
require_relative '../View/terminal_view_department_instance'

class Controller_department_list < Controller_list
  public_class_method :new

  def initialize
    @list = Department_list.new
    @list.read_DB
    @view_list = Terminal_view_department_list.new(self)
  end

  def show_list
    puts @list
  end

  def add
    print 'Введите название отдела:'
    dep_name = gets.chomp
    DB_work.db_work.add_department(dep_name)
    dep = Department.new(dep_name)
    @list.add(dep)
  end

  def choose_instance(num)
    instance = @list.choose(num)
    Terminal_view_department_instance.new(Controller_department_instance.new(instance))
  end

  def delete_instance
    @list.delete(@instance)
    @instance = nil
  end

  def close
    @list.write_list_yaml
    exit
  end
end