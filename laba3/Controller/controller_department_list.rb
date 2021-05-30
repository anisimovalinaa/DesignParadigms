require_relative 'controller_list'
require_relative 'Instance/controller_department_instance'
require_relative '../View/terminal_view_department_list'
require_relative '../View/terminal_view_department_instance'
require_relative '../Controller/Factory_instance/controller_department_instance_factory'

class Controller_department_list < Controller_list
  public_class_method :new
  attr_reader :instance

  def initialize
    @list = Department_list.new
    @list.read_DB
    @view_list = Terminal_view_department_list.new(self)
  end

  def show_list
    @list
  end

  def add(dep_name)
    DB_work.db_work.add_department(dep_name)
    dep = Department.new(dep_name)
    @list.add(dep)
  end

  def choose_instance(num)
    @instance = @list.choose(num)
  end

  def show_instance
    controller_instance = Controller_department_instance_factory.new
    controller_instance = controller_instance.create_controller_instance(@instance)
    Terminal_view_department_instance.new(controller_instance).show
  end

  def delete_instance
    if @instance == nil
      raise ArgumentError
    else
      @list.delete(@instance)
      @instance = nil
    end
  end

  def change_instance(name)
    if @instance == nil
      raise ArgumentError
    else
      @instance.name = name
      @list.change(@instance)
    end
  end

  def close
    @list.write_list_yaml
    exit
  end
end