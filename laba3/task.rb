require 'fox16'
include Fox

class HelloWorld < FXMainWindow
  def initialize(app, t)
    super(app, "Hello, #{t}" , :width => 200, :height => 50)
  end
  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

def show_window(t)
  app = FXApp.instance || FXApp.new
  app.create
  w = HelloWorld.new(app, t)
  w.create
  app.run
end

show_window(1)
show_window(2)
show_window(1)