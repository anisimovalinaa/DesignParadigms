require_relative 'activity'

class Developer
  attr_writer :activity

  def execute_activity
    @activity.just_do_it
  end
end