require_relative 'developer_factory'
require_relative 'java_developer'

class Java_Developer_Factory < Developer_Factory
  def create_developer
    Java_Developer.new
  end
end