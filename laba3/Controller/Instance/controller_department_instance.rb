require_relative 'controller_instance'
require_relative '../../View/terminal_view_department_instance'

class Controller_department_instance < Controller_instance
  attr_reader :instance_post

  def initialize(instance)
    @instance = instance
    @view = Terminal_view_department_instance.new(self)
  end

  def show_posts
    @instance.post_list
  end

  def choose_post(num)
    @instance_post = @instance.choose(num)
  end

  def delete
    if @instance_post == nil
      raise ArgumentError
    else
      @instance.delete(@instance_post)
      @instance_post = nil
    end
  end

  def change(post_name, fixed_salary, fixed_premium, quarterly_award, possible_bonus)
    if @instance_post == nil
      raise ArgumentError
    else
      @instance_post.post_name = post_name
      @instance_post.fixed_salary = fixed_salary
      @instance_post.fixed_premium = fixed_premium
      @instance_post.quarterly_award = quarterly_award
      @instance_post.possible_bonus = possible_bonus
      @instance.change(@instance_post)
    end
  end

  def add(post_name, fixed_salary, fixed_premium, quarterly_award, possible_bonus)
    post = DB_work.db_work.add_post(post_name, fixed_salary, fixed_premium, quarterly_award, possible_bonus, @instance.id)
    @instance.add_post(post)
  end

  def get_vacant_emp
    DB_work.db_work.read_vacant_emp
  end

  def set_emp(phone_number)
    if @instance_post == nil
      raise ArgumentError
    else
      emp = DB_work.db_work.find_emp_phone(phone_number)
      @instance_post.emp = emp
      DB_work.db_work.set_emp(@instance_post)
    end
  end

end