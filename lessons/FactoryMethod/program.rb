require_relative 'java_developer_factory'
require_relative 'cpp_developer_factory'


class Program
  def self.main
    developer_factory = Java_Developer_Factory.new
    developer = developer_factory.create_developer

    developer.write_code
  end
end

if $0 == __FILE__
  Program.main
end