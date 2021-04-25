require_relative 'salary'
require_relative 'employee'

class Post
  attr_accessor :post_name, :fixed_salary, :fixed_premium, :quarterly_award, :possible_bonus, :department, :emp, :salary
  def initialize(post_name, fixed_salary, fixed_premium, quarterly_award, possible_bonus,
                 department, emp)
    self.post_name = post_name
    self.fixed_salary = fixed_salary
    self.fixed_premium = fixed_premium
    self.quarterly_award = quarterly_award
    self.possible_bonus = possible_bonus
    self.department = department
    self.emp = emp
    self.salary = PossibleBonus.new(FixedPremium.new(QuarterlyAward.new(FixedSalary.new(
      Salary.new(), self.fixed_salary), self.quarterly_award), self.fixed_premium), self.possible_bonus + 1.0).get_salary
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
      @emp = x
    rescue ArgumentError => e
      e.message
    end
  end

end



emp1 = Employee.new('лапавм вк ренр', '31.08.2000', '77777777777', 'fghjk', 'vergre@gfbfbf.grt',  '5555555555', 'fgbbth', 0)
post = Post.new('lala', 10, 20, 30, 0.3, 'lala2', emp1)
# # post.emp = emp1
#
puts post.salary