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
    if @department != nil
      @post_list = DB_work.db_work.read_post_list(@department.name)
    else
      @post_list = DB_work.db_work.read_vacant_posts
    end
  end

  def add(post)
    @post_list << post
  end

  def delete(post)
    DB_work.db_work.delete_post(post)
    read_DB
  end

  def change(post)
    DB_work.db_work.change_post(post)
    read_DB
  end

  def choose(num)
    @post_list.each do |post|
      return post if post.id == num
    end
  end

  def to_s
    result = ''
    @post_list.each do |post|
      result += post.to_s + "\n"
    end
    result
  end
end