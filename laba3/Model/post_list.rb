require_relative 'department'
require_relative 'post'
require_relative 'db_work'

# Класс для хранения должностей конкретного отдела
# :title:Post_list
class Post_list
  attr_accessor :post_list, :department

  # Метод класса +new+ инициализирует класс
  def initialize(department = nil) # объект класса department
    self.post_list = []
    self.department = department
  end

  # Метод объекта +read_DB+ считывает список должностей из базы данных
  def read_DB
    if @department != nil
      @post_list = DB_work.db_work.read_post_list(@department.name)
    else
      @post_list = DB_work.db_work.read_vacant_posts
    end
  end

  # Метод объекта +add+ добавляет должность
  # === Parameters
  # * _post_ - новая должность
  def add(post)
    @post_list << post
  end

  # Метод объекта +delete+ удаляет должность
  # === Parameters
  # * _post_ - должность
  def delete(post)
    DB_work.db_work.delete_post(post)
    read_DB
  end

  # Метод объекта +change+ вносит изменения в должность
  # === Parameters
  # * _post_ - отдел
  def change(post)
    DB_work.db_work.change_post(post)
    read_DB
  end

  # Метод объекта +choose+ выбирает должность по номеру
  # === Parameters
  # * _num_ - номер должность
  def choose(num)
    @post_list.each do |post|
      return post if post.id == num
    end
  end

  # Метод объекта +to_s+. Возрвращает объект в строковом представлении
  def to_s
    result = ''
    @post_list.each do |post|
      result += post.to_s + "\n"
    end
    result
  end
end