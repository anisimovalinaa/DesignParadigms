require_relative 'post_list'

class Department
  attr_accessor :name, :post_list
  def initialize(name)
    self.name = name
  end

  def read_DB
    @post_list = Post_list.new(Department.new(@name))
    @post_list.read_DB
  end

  def delete(department)
    DB_work.db_work.delete_department(department)
    read_DB
  end

end