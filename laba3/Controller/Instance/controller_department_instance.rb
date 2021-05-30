require_relative 'controller_instance'
require_relative '../../View/terminal_view_department_instance'

class Controller_department_instance < Controller_instance
  def initialize(instance)
    @instance = instance
    @view = Terminal_view_department_instance.new(self)
  end

  def show_instance
    @instance
  end

  def show_posts
    @instance.post_list
  end
end