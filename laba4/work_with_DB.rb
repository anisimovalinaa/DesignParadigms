require 'mysql2'
require_relative 'abonents'

class WorkWithDB
  def initialize(list_ab)
    @connection = Mysql2::Client.new(
      :host => 'localhost',
      :username => 'alina',
      :password => 'mama',
      :database => 'according_telephone_conversations',
      )
    @list_ab = list_ab
  end

  def update_DB list
    list.each do |record|
      res = @connection.query("SELECT count(*) FROM abonents WHERE inn = '#{record.inn}'")
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
    results = @connection.query("SELECT * FROM abonents")
    results.each do |row|
      user = Abonent.new(row['inn'].to_i, row['name'], row['phone_number'], row['bank_account'])
      @list_ab.add_abonent(user)
    end
  end

  def add_to_DB(user)
    # @connection.query("INSERT INTO `according_telephone_conversations`.`abonents` (`inn` ,`name` ,`phone_number` ,
    #                         `bank_account`)
    #                       VALUES ('#{user.inn}', '#{user.name}', #{user.phone_number}', '#{user.bank_account}')")
    @connection.query("INSERT INTO `according_telephone_conversations`.`abonents` (`inn` ,`name` ,`phone_number` ,
                            `bank_account`)
                          VALUES ('#{user.inn}', '#{user.name}', '#{user.phone_number}', '#{user.bank_account}');")
  end

  def change_node(user)
    @connection.query("UPDATE abonents SET name = '#{user.name}', phone_number = '#{user.phone_number}',
                  bank_account = '#{user.bank_account}'
                  WHERE inn = '#{user.inn}'")
  end

  def delete_from_db(user)
    @connection.query("DELETE FROM abonents WHERE inn = '#{user.inn}'")
  end

  def close
    @connection.close
  end
end
