class Activity
  def just_do_it
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end