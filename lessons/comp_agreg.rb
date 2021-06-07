require 'rdoc'

RDoc::Page('abstract.rb')


class Past_of_class
  attr_accessor :field1
  def initialize(field1)
    self.field1 = field1
  end
end

class My_class_comp
  attr_accessor :part_of_class

  def initialize(field1)
    self.part_of_class = Past_of_class.new(field1)
  end

  def to_s
    "composition field = #{part_of_class.field1}"
  end
end

class My_class_agreg
  attr_accessor :part_of_class

  def initialize(part_of_class)
    self.part_of_class = part_of_class
  end

  def to_s
    "aggregation field = #{part_of_class.field1}"
  end
end

def main
  part_of_class = Past_of_class.new(2)
  my_class_agreg = My_class_agreg.new(part_of_class)
  my_class_comp = My_class_comp.new(3)
  puts my_class_agreg
  puts my_class_comp
end

main

