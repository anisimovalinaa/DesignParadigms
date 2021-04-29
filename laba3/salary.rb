class Salary
  attr_accessor :salary

  def get_salary
    self.salary = 0
  end

  def self.empty_salary
    FixedSalary.new(Salary.new, 0).get_salary
  end

  def self.bonus_and_quart(bonus_size, quart_size)
    PossibleBonus.new(QuarterlyAward.new(Salary.new, quart_size), bonus_size).get_salary
  end

  def self.premium(size_premium, size_fixed)
    FixedPremium.new(FixedSalary.new(Salary.new, size_fixed), size_premium).get_salary
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
class FixedSalary < Decorator
  def get_salary
    super + @size_salary
  end
end

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
    super * (@size_salary / 100 + 1)
  end
end

# new_salary = Salary.new
# decorator2 = PossibleBonus.new(FixedPremium.new(QuarterlyAward.new(FixedSalary.new(new_salary, 10), 20), 30), 1.2)
#
# puts decorator2.get_salary
#
# puts PossibleBonus.new(FixedPremium.new(QuarterlyAward.new(FixedSalary.new(
#   Salary.new(), 10), 20), 30), 0.4 + 1.0).get_salary
#

# puts Salary.premium(47, 20)
