require_relative 'department'
require_relative 'post'
require_relative 'db_work'

class Post_list
  attr_accessor :post_list, :department
  def initialize(dep_name = nil)
    self.post_list = []
    self.department = Department.new
    @connection = DB_work.connection
  end

  def read_DB
    @post_list = @connection.read_post_list(@department.name_dep)
  end

  def add(post)
    @post_list << post
  end

  def choose(num)
    @post_list[num]
  end
end

post_list = Post_list.new('Лала')

