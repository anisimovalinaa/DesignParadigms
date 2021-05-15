require_relative '../Model/department_list'

class Terminal_view_list
  def initialize(controller_list)
    @controller_list = controller_list
  end

  def show # меню
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def show_list
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def сlose
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end