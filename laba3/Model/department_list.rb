require_relative 'db_work'
require_relative 'department'
require 'yaml'

# Класс для хранения списка отделов
# :title:Department_list
class Department_list
  attr_accessor :department_list

  # Метод класса +new+ инициализирует класс
  def initialize
    self.department_list = []
  end

  # Метод объекта +read_DB+ считывает список отделов из базы данных
  def read_DB
    dep_names = DB_work.db_work.read_dep_names
    dep_names.each do |name|
      id = DB_work.db_work.find_departmentID(name)
      dep = Department.new(id, name)
      dep.read_DB
      add(dep)
    end
  end

  # Метод объекта +change+ вносит изменения в отдел
  # === Parameters
  # * _department_ - отдел
  def change(department)
    DB_work.db_work.change_department(department)
    @department_list = []
    read_DB
  end

  # Метод объекта +add+ добавляет отдел
  # === Parameters
  # * _department_ - новый отдел
  def add(department)
    @department_list << department
  end

  # Метод объекта +delete+ удаляет отдел
  # === Parameters
  # * _department_ - отдел
  def delete(department)
    DB_work.db_work.delete_department(department)
    @department_list = []
    read_DB
  end

  # Метод объекта +choose+ выбирает отдел по номеру
  # === Parameters
  # * _num_ - номер отдела
  def choose(num)
    @department_list.each do |dep|
      return dep if dep.id == num
    end
  end

  # Метод объекта +read_list_yaml+ считывает отделы из файла типа YAML
  def read_list_yaml
    @department_list = YAML::load(File.open('../dep_list.yaml'))
  end

  # Метод объекта +write_list_yaml+ записывает отделы в файл типа YAML
  def write_list_yaml
    File.open('Sources/dep_list.yaml', 'w:UTF-8') do |file|
      file.puts(@department_list.to_yaml)
    end
  end

  # Метод объекта +to_s+. Возрвращает объект в строковом представлении
  def to_s
    result = ''
    @department_list.each do |dep|
      result += dep.to_s + "\n"
    end
    result
  end
end