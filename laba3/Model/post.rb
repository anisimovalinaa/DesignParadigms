require_relative 'salary'
require_relative '../Model/employee'

class Post
  attr_accessor :post_name, :fixed_salary, :fixed_premium, :quarterly_award, :possible_bonus, :department, :salary
  attr_reader :emp, :id
  def initialize(id, post_name, fixed_salary, fixed_premium, quarterly_award, possible_bonus,
                 department)
    @id = id
    self.post_name = post_name
    self.fixed_salary = fixed_salary
    self.fixed_premium = fixed_premium
    self.quarterly_award = quarterly_award
    self.possible_bonus = possible_bonus
    self.department = department
    self.salary = PossibleBonus.new(FixedPremium.new(QuarterlyAward.new(FixedSalary.new(
      Salary.new, self.fixed_salary), self.quarterly_award), self.fixed_premium), self.possible_bonus)
  end

  def self.is_emp?(x)
    if x.class == Employee
      @post_list = x
    else
      raise ArgumentError 'Это не работник'
    end
  end

  def emp=(x)
    begin
      Post.is_emp?(x)
      x.post = self
      @emp = x
    rescue ArgumentError => e
      e.message
    end
  end

  def to_s
    "#{post_name}, #{salary.get_salary}"
  end
end



# emp1 = Employee.new('лапавм вк ренр', '31.08.2000', '77777777777', 'fghjk', 'vergre@gfbfbf.grt',  '5555555555', 'fgbbth', 0)
# post = Post.new('lala', 10, 20, 30, 0.3, 'lala2')
# post.emp = emp1
#
# puts post.emp