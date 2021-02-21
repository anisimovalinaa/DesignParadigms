puts 'Введите команду языка ruby:'
ruby_comand = gets.chomp
eval ruby_comand
puts 'Введите команду ОС:'
oc_comand = gets.chomp
puts `#{oc_comand}`
