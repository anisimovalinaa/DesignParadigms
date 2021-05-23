require_relative 'controller_instance'

class Controller_department_instance < Controller_instance
  def initialize(instance)
    @instance = instance
  end

  def show_instance
    @instance
  end

  def show_posts
    @instance.post_list
  end
end