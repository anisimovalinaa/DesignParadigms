require_relative 'Model/post_list'
require_relative 'Model/post'
require_relative 'Model/employee'
require 'mysql2'

class DB_work
  @@db_work = nil

  def initialize
    @connection = Mysql2::Client.new(
      :host => 'localhost',
      :username => 'root',
      :database => 'staff',
      )
  end

  def self.db_work
    if @@db_work == nil
      @@db_work = DB_work.new
    end
    @@db_work
  end

  def add_department(department_name)
    @connection.query("INSERT INTO `staff`.`departments` (`departmentName`) VALUES ('#{department_name}')")
  end

  def add_post(post)
    bool_premium = post.fixed_salary > 0 ? 1 : 0
    bool_quarterly = post.fixed_salary > 0 ? 1 : 0
    bool_bonus = post.fixed_salary > 0 ? 1 : 0
    @connection.query("INSERT INTO `staff`.`post` (`PostName`, `FixedSalary`, `FixedPremiumBool`,
                      `FixedPremiumSize`, `QuarterlyAwardBool`, `QuarterlyAwardSize`, `PossibleBonusBool`,
                      `PossibleBonusPercent`, `DepartmentID` )
                      VALUES ('#{post.post_name}', #{post.fixed_salary}, #{bool_premium}, #{post.fixed_premium},
                      #{bool_quarterly}, #{post.quarterly_award}, #{bool_bonus}, #{post.possible_bonus},
                      #{post.department.id})")
  end

  def find_departmentID(dep_name)
    res = @connection.query("SELECT departmentID FROM departments WHERE departmentName = '#{dep_name}'")
    res.each { |row| return row['departmentID']}
  end

  def find_employee(id)
    emp = Object.new()
    res = @connection.query("SELECT * FROM employees WHERE EmployeeID = #{id}")
    res.each do |row|
      data = row['datebirth'].to_s.split('-').reverse.join('.')
      if row['work_experience'] > 0
        emp = Employee.new(row['FIO'], data, row['phone_number'], row['address'],
                           row['e_mail'], row['passport'], row['speciality'], row['work_experience'],
                           row['last_workplace'], row['last_post'], row['last_salary'])
      else
        emp = Employee.new(row['FIO'], data, row['phone_number'], row['address'],
                           row['e_mail'], row['passport'], row['speciality'], row['work_experience'])
      end
    end
    emp
  end

  def read_employee_list
    results = @connection.query("SELECT * FROM employees")
    list_emp = ListEmployee.new
    results.each do |row|
      data = row['datebirth'].to_s.split('-').reverse.join('.')
      if row['work_experience'] > 0
        emp = Employee.new(row['FIO'], data, row['phone_number'], row['address'],
                           row['e_mail'], row['passport'], row['speciality'], row['work_experience'],
                           row['last_workplace'], row['last_post'], row['last_salary'])
      else
        emp = Employee.new(row['FIO'], data, row['phone_number'], row['address'],
                           row['e_mail'], row['passport'], row['speciality'], row['work_experience'])
      end
      list_emp.add_user(emp)
    end
    list_emp
  end

  def read_post_list(dep_name)
    id_dep = find_departmentID(dep_name)

    post_list = []

    results = @connection.query("SELECT * FROM post WHERE DepartmentID = #{id_dep}")
    results.each do |row|
      fixed_premium = row['FixedPremiumBool'] == 1 ? row['FixedPremiumSize'] : 0
      quarterly_award = row['QuarterlyAwardBool'] == 1 ? row['QuarterlyAwardSize'] : 0
      possible_bonus = row['PossibleBonusBool'] == 1 ? row['PossibleBonusPercent'] : 0
      emp = find_employee(row['EmployeeID']) if row['EmployeeID'] != nil

      post = Post.new(row['PostID'], row['PostName'], row['FixedSalary'], fixed_premium, quarterly_award, possible_bonus, dep_name)
      post.emp = emp if emp.class == Employee
      post_list << post
    end

    post_list
  end

  def find_dep_name(dep_id)
    res = @connection.query("SELECT departmentName FROM departments WHERE departmentID = #{dep_id}")
    res.each { |row| return row['departmentName'] }
  end

  def read_vacant_posts
    post_list = []
    res = @connection.query("SELECT * FROM post WHERE EmployeeID IS NULL")
    res.each do |row|
      fixed_premium = row['FixedPremiumBool'] == 1 ? row['FixedPremiumSize'] : 0
      quarterly_award = row['QuarterlyAwardBool'] == 1 ? row['QuarterlyAwardSize'] : 0
      possible_bonus = row['PossibleBonusBool'] == 1 ? row['PossibleBonusPercent'] : 0
      dep_name = find_dep_name(row['DepartmentID'])
      post = Post.new(row['PostID'], row['PostName'], row['FixedSalary'], fixed_premium, quarterly_award, possible_bonus, dep_name)
      post_list << post
    end

    post_list
  end

  def read_dep_names
    dep_names = []
    res = @connection.query("SELECT DISTINCT departmentName FROM departments")
    res.each do |row|
      dep_names << row['departmentName']
    end
    dep_names
  end

  def delete_post(post)
    id = post.id
    @connection.query("DELETE FROM post WHERE PostID = #{id}")
  end

  def delete_department(department)
    @connection.query("DELETE FROM departments WHERE departmentName = #{department.name}")
  end

  def change_post(post)
    fixed_premium_bool = post.fixed_premium > 0 ? 1 : 0
    quarterly_award_bool = post.quarterly_award > 0 ? 1 : 0
    possible_bonus_bool = post.possible_bonus > 0 ? 1 : 0
    @connection.query("UPDATE post
                           SET FixedSalary = #{post.fixed_salary},
                               FixedPremiumSize = #{post.fixed_premium},
                               FixedPremiumBool = #{fixed_premium_bool},
                               QuarterlyAwardSize = #{post.quarterly_award},
                               QuarterlyAwardBool = #{quarterly_award_bool},
                               PossibleBonusPercent = #{post.possible_bonus}
                               PossibleBonusBool = #{possible_bonus_bool}
                           WHERE PostID = #{post.id}")
  end

  def change_department(department)
    @connection.query("UPDATE departments
                           SET departmentName = #{department.name}
                           WHERE departmentID = #{department.id}")
  end
end