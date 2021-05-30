require_relative 'controller_instance'
require_relative '../../View/terminal_view_department_instance'

class Controller_department_instance < Controller_instance
  attr_reader :instance_post

  def initialize(instance)
    @instance = instance
    @view = Terminal_view_department_instance.new(self)
  end

  def show_posts
    @instance.post_list
  end

  def choose_post(num)
    @instance_post = @instance.choose(num)
  end

  def delete
    if @instance_post == nil
      raise ArgumentError
    else
      @instance.delete(@instance_post)
      @instance_post = nil
    end
  end
end