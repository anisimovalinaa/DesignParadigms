require_relative 'post_list'
require_relative 'work_with_DB'

class Department
  attr_accessor :name_dep, :post_list
  def initialize
    self.name_dep = name_dep
    self.post_list = post_list
  end

  def self.is_post_list?(x)
    if x.class == Post_list
      @post_list = x
    else
      raise ArgumentError 'Это не список должностей'
    end
  end

  def post_list=(x)
    begin
      Department.is_post_list?(x)
      @post_list = x
    rescue ArgumentError => e
      e.message
    end
  end
end

# dep = Department.new('lsld', [])