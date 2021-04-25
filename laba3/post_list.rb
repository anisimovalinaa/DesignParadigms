require_relative 'department'
require_relative 'post'

class Post_list
  attr_accessor :post_list, :department
  def initialize(dep_name = nil)
    self.post_list = []
    self.department = Department.new(dep_name, post_list)
  end

  def read_DB_posts(dep_name)
    connection = Mysql2::Client.new(
      :host => 'localhost',
      :username => 'alina',
      :password => 'mama',
      :database => 'staff',
      )
    id_dep = connection.query("SELECT departmentID from departments WHERE departmentName = #{dep_name}")
    results = connection.query("SELECT * FROM post WHERE department = #{id_dep}")

    results.each do |row|
      fixed_premium = row['FixedPremiumBool'] == 1 ? row['FixedPremiumSize'] : nil
      quarterly_award = row['QuarterlyAwardBool'] == 1 ? row['QuarterlyAwardSize'] : nil
      possible_bonus = row['PossibleBonusBool'] == 1 ? row['PossibleBonusPercent'] : nil
      emp_res = connection.query("SELECT * FROM employees WHERE employeeID = #{row['EmployeeID']}")
      emp = Object.new()
      emp_res.each { |row|
        if row['work_experience'] > 0
          emp = Employee.new(row['FIO'], data, row['phone_number'], row['address'],
                             row['e_mail'], row['passport'], row['speciality'], row['work_experience'],
                             row['last_workplace'], row['last_post'], row['last_salary'])
        else
          emp = Employee.new(row['FIO'], data, row['phone_number'], row['address'],
                             row['e_mail'], row['passport'], row['speciality'], row['work_experience'])
        end
      }
      post = Post.new(row['PortName'], row['FixedSalary'], fixed_premium, quarterly_award, possible_bonus, dep_name, emp)
      add(post)
    end
    connection.close
    @post_list = results
  end

  def add(post)
    @post_list << post
  end

  def choose(num)
    @post_list[num]
  end
end
