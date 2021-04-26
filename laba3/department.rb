require_relative 'post_list'
require_relative 'work_with_DB'

class Department
  attr_accessor :name_dep, :post_list
  def initialize(name_dep)
    self.name_dep = name_dep
  end

  def read_DB

  end
end

# dep = Department.new('lsld')
# puts dep.post_list
# dep.post_list = []
# print dep.post_list