require_relative 'post_list'
require_relative 'db_work'

class Department
  attr_accessor :name, :post_list
  attr_reader :id
  def initialize(name)
    self.name = name
    @id = DB_work.db_work.find_departmentID(name)
  end

  def read_DB
    @post_list = Post_list.new(self)
    @post_list.read_DB
  end

  def to_s
    id.to_s + ". " + name
  end

  def add_post(post)
    @post_list.add(post)
  end

  def posts
    @post_list
  end
end