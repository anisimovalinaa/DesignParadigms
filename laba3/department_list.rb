class Department_list
  attr_accessor :department_list

  def initialize
    self.department_list = []
  end

  def read_DB
    # department_list =
  end

  def add(department)
    @department_list << department
  end

  def choose(num)
    @department_list[num]
  end
end