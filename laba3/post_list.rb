require_relative 'department'
require_relative 'post'
require_relative 'db_work'

class Post_list
  attr_accessor :post_list, :department
  def initialize(department = nil) # объект класса department
    self.post_list = []
    self.department = department
  end

  def read_DB
    @post_list = DB_work.db_work.read_post_list(@department.name_dep)
  end

  def add(post)
    @post_list << post
  end

  def choose(num)
    @post_list[num]
  end
end