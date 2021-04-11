require 'mysql2'
require_relative 'listEmployee'

class WorkWithDB
  attr_accessor :list_emp
  def initialize(list_emp)
    @connection = Mysql2::Client.new(
      :host => 'localhost',
      :username => 'alina',
      :password => 'mama',
      :database => 'staff',
      )
    self.list_emp = list_emp
  end

  def update_DB list
    list.each do |record|
      res = @connection.query("SELECT count(*) FROM employees WHERE passport = '#{record.passport}'")
      count = 0
      res.each { |row| count = row['count(*)']}
      if count > 0
        change_node(record)
      else
        add_to_DB(record)
      end
    end
  end

  def read_list_DB()
    results = @connection.query("SELECT * FROM employees")
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
      @list_emp.add_user(emp)
    end
  end

  def add_to_DB(user)
    date = user.datebirth.to_s.split('.').reverse.join('-')
    begin
      @connection.query("INSERT INTO `staff`.`employees` (`FIO` ,`datebirth` ,`phone_number` ,`address` ,`e_mail` ,
                              `passport` ,`speciality` ,`work_experience`, `last_workplace` ,`last_post` ,`last_salary`)
                            VALUES ('#{user.fio}', '#{date}', '#{user.phone_number}', '#{user.address}', '#{user.e_mail}',
                              '#{user.passport}', '#{user.speciality}', #{user.work_experience.to_i},
                              '#{user.last_workplace}', '#{user.last_post}', #{user.last_salary.to_i})")
    rescue NameError
      @connection.query("INSERT INTO `staff`.`employees` (`FIO` ,`datebirth` ,`phone_number` ,`address` ,`e_mail` ,
                              `passport` ,`speciality` ,`work_experience`)
                            VALUES ('#{user.fio}', '#{date}', '#{user.phone_number}', '#{user.address}', '#{user.e_mail}',
                              '#{user.passport}', '#{user.speciality}', #{user.work_experience.to_i})")
    end
  end

  def change_node(emp)
    date = emp.datebirth.to_s.split('.').reverse.join('-')
    begin
      @connection.query("UPDATE employees SET FIO = '#{emp.fio}', datebirth = '#{date}',
										phone_number = '#{emp.phone_number}', address = '#{emp.address}',
										e_mail = '#{emp.e_mail}', passport = '#{emp.passport}', speciality = '#{emp.speciality}',
										work_experience = '#{emp.work_experience}', last_workplace = '#{emp.last_workplace}',
										last_post = '#{emp.last_post}', last_salary = '#{emp.last_salary}'
										WHERE passport = '#{emp.passport}'")
    rescue NameError
      @connection.query("UPDATE employees SET FIO = '#{emp.fio}', datebirth = '#{date}',
										phone_number = '#{emp.phone_number}', address = '#{emp.address}',
										e_mail = '#{emp.e_mail}', passport = '#{emp.passport}', speciality = '#{emp.speciality}',
										work_experience = '#{emp.work_experience}'
										WHERE passport = '#{emp.passport}'")
    end
  end

  def delete_from_db(emp)
    @connection.query("DELETE FROM employees WHERE passport = '#{emp.passport}'")
  end

  def close
    @connection.close
  end
end