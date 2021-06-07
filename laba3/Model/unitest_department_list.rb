require_relative 'department_list'
require_relative 'department'

def unitest_department_list
    puts 'Тест 1. Создание, считывание из базы, вывод.'
    puts 'Считываем список отделов и выводим'
    dep_list = Department_list.new
    dep_list.read_DB
    puts dep_list

    puts "\nТест 2. Изменение."
    puts "Изменяем отдел номер 6"
    dep_change = Department.new(6, 'Отдел АСУП')
    dep_list.change(dep_change)
    puts dep_list

    puts "\nТест 3. Добавление."
    puts "Добавляем отдел 'Юридическая служба'"
    dep_add = Department.new(7, 'Юридическая служба')
    dep_list.add(dep_add)
    puts dep_list

    puts "\nТест 4. Удаление."
    puts "Удаляем отдел 'Юридическая служба'"
    dep_list.delete(dep_add)
    puts dep_list

    puts "\nТест 5. Выбор."
    puts "Выберем отдел номер 2"
    puts dep_list.choose(2)
end

unitest_department_list

