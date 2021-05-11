class Controller_List_Factory
  def create_controller_list
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end