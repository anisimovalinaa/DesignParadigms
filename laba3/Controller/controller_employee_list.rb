require_relative '../View/terminalViewListEmployee'
require_relative '../Model/listEmployee'
require_relative 'controller_list'

class Controller_employee_list < Controller_list
  public_class_method :new

  def initialize
    @list = ListEmployee.new
    @list.read_DB
    @view_list = Terminal_view_list_employee.new(self)
  end

  def show_list
    puts @list
  end

  def close
  	exit
  end

  def show_view
    ans = ''
    while ans != '0'
      puts "--------Меню-------", '1. Добавить нового пользователя.',
           '2. Отобразить список пользователей', '3. Найти пользователя по введенным данным.',
           '4. Изменить конкретного пользователя.', '5. Удалить пользователя.',
           '6. Сохранить изменения в файл.', '7. Сортировать по конкретному полю.', '0. Закрыть программу.'
      print 'Ответ: '
      ans = gets.chomp
      case ans
      when '2'
        show_list
        puts
      when '0'
        close
      else
        puts 'Такого пункта нет'
      end
    end
  end
end