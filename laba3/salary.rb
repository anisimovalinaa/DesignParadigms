class Salary
  attr_accessor :salary

  def get_salary
    self.salary = 10
  end
end

class Decorator < Salary
  attr_accessor :salary
  attr_writer :size_salary

  def initialize(salary, size_salary)
    self.salary = salary
    self.size_salary = size_salary
  end

  def get_salary
    @salary.get_salary
  end
end
#
# class FixedSalary < Decorator
#   def get_salary
#     super + 10
#   end
# end

class FixedPremium < Decorator
  def get_salary
    super + @size_salary
  end
end

class QuarterlyAward < Decorator
  def get_salary
    super + @size_salary
  end
end

class PossibleBonus < Decorator
  def get_salary
    super * @size_salary
  end
end

new_salary = Salary.new
decorator2 = PossibleBonus.new(FixedPremium.new(QuarterlyAward.new(new_salary, 20), 30), 1.2)

puts decorator2.get_salary
