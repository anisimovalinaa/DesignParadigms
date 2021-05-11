require_relative 'controller_department_list'

class Main
  def self.main
    @@controller = Controller_department_list.new
    @@controller.show_view
  end
end

if $0 == __FILE__
  Main.main
end