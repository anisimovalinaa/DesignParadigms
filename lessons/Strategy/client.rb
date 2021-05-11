require_relative 'developer'
require_relative 'sleeping'
require_relative 'reading'
require_relative 'training'
require_relative 'coding'

class Client
  def self.main
    developer = Developer.new

    developer.activity = Sleeping.new
    developer.execute_activity

    developer.activity = Coding.new
    developer.execute_activity

    developer.activity = Reading.new
    developer.execute_activity

    developer.activity = Training.new
    developer.execute_activity
  end
end

if $0 == __FILE__
  Client.main
end