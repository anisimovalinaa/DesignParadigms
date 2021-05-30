require 'fox16'
include Fox

class Window_department_instance < FXMainWindow
  def initialize(app, instance, controller_instance)
    super(app, "Staff" , :width => 600, :height => 400)
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end