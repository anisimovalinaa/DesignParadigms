require_relative 'post_list'

class DB_work
  @@db_work = nil

  def initialize
    @connection = Mysql2::Client.new(
      :host => 'localhost',
      :username => 'alina',
      :password => 'mama',
      :database => 'staff',
      )
  end

  def self.db_work
    if @@db_work == nil
      @@db_work = DB_work.new()
    end
    @@db_work
  end

  def self.find_departmentID(dep_name)
    res = @connection.query("SELECT departmentID FROM departments WHERE departmentName = #{dep_name}")
    res.each { |row| return row['departmentID']}
  end

  def self.find_employee(id)
    @connection.query("SELECT * FROM employees WHERE EmployeeID = #{id}")
  end

  def read_post_list(dep_name)
    res_id = @connection.query("SELECT departmentID FROM departments WHERE departmentName = #{dep_name}")
    res_id.each { |row| return row['departmentID']}
    id_dep = DB_work.find_departmentID(dep_name)


    post_list = []

    results = @connection.query("SELECT * FROM post WHERE department = #{id_dep}")
    results.each do |row|
      fixed_premium = row['FixedPremiumBool'] == 1 ? row['FixedPremiumSize'] : nil
      quarterly_award = row['QuarterlyAwardBool'] == 1 ? row['QuarterlyAwardSize'] : nil
      possible_bonus = row['PossibleBonusBool'] == 1 ? row['PossibleBonusPercent'] : nil
      emp_res = DB_work.find_employee(row['EmployeeID'])
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
      post_list << post
    end

    post_list
  end

  def read_department(dep_name)
    id_dep = DB_work.find_departmentID(dep_name)
    result = @connection.query("SELECT * FROM post WHERE DepartmentID = #{id_dep}")
  end
end