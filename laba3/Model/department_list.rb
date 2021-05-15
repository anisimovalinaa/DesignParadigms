require_relative '../db_work'
require_relative 'department'
require 'yaml'

class Department_list
  attr_accessor :department_list

  def initialize
    self.department_list = []
  end

  def read_DB
    dep_names = DB_work.db_work.read_dep_names
    dep_names.each do |name|
      dep = Department.new(name)
      dep.read_DB
      add(dep)
    end
  end

  def change(department)
    DB_work.db_work.change_department(department)
    read_DB
  end

  def add(department)
    @department_list << department
  end

  def delete(department)
    DB_work.db_work.delete_department(department)
    read_DB
  end

  def choose(num)
    @department_list.each do |dep|
      return dep if dep.id == num
    end
  end

  def read_list_yaml
    @department_list = YAML::load(File.open('../dep_list.yaml'))
  end

  def write_list_yaml
    File.open('dep_list.yaml', 'w:UTF-8') do |file|
      file.puts(@department_list.to_yaml)
    end
  end

  def to_s
    result = ''
    @department_list.each do |dep|
      result += dep.to_s + "\n"
    end
    result
  end
end