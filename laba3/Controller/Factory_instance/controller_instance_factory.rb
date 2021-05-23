class Controller_instance_factory
  def create_controller_instance
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end