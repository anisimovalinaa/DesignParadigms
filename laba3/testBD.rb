require 'mysql2'

client = Mysql2::Client.new(
  :host => 'localhost', # 主机
  :username => 'alina',
  :password => 'mama',
  :database => 'staff',      # 数据库
)
results = client.query("SELECT * FROM employees")
results.each do |row|
  puts row
end