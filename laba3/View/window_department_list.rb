require 'fox16'
require_relative '../Controller/Factory_list/controller_department_list_factory'
include Fox

class Window_department_list < FXMainWindow
  attr_accessor :hFrame1
  def initialize(app, controller_list)
    @controller_list = controller_list
    super(app, "Staff" , :width => 600, :height => 400)
    self.hFrame1 = FXHorizontalFrame.new(self)
    show_dep
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  def show_dep
    FXTable
    FXLabel.new(@hFrame1, @controller_list.show_list.to_s)
  end
end