require_relative 'developer_factory'
require_relative 'cpp_developer'

class Cpp_Developer_Factory < Developer_Factory
  def create_developer
    Cpp_Developer.new
  end
end