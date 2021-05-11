require_relative 'controller'
require_relative 'terminal_view_department_list'
require_relative 'department_list'

class Controller_list
  # private_class_method :new

  def show_view
    @view_list.show
  end

  def show_list
    @view_list.show_list
  end

  def choose_instance(number)
    @view_list.choose_instance(number)
  end

  def add_instance(*args)
    @list.add(args)
  end

  def show_instance
    @view_list.show_instance
  end

  def delete_instance
    @view_list.delete_instance
  end

  def close_view
    @view_list.close
  end

end