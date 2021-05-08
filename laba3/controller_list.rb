require_relative 'controller'
require_relative 'terminal_view_department_list'
require_relative 'department_list'

class Controller_list
  include Controller

  def initialize
    @list = Department_list.new
    @list.read_DB
    @view_list = Terminal_view_department_list.new(@list)
  end

  def show_view
    @view_list.show
  end

  def show_list
    @view_list.show_list
  end

  def choose_instance(number)
    @list.choose(number)
  end

  def add_instance(*args)
    @list.add(args)
  end

  def show_instance

  end

  def delete_instance

  end

  def close_view

  end

end