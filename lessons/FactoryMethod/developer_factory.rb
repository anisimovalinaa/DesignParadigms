class Developer_Factory
  def create_developer
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end