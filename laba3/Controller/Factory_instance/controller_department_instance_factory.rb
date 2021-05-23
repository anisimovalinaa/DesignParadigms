require_relative 'controller_instance_factory'
require_relative '../Instance/controller_department_instance'

class Controller_department_instance_factory < Controller_instance_factory
  def create_controller_instance(instance)
    Controller_department_instance.new(instance)
  end
end