require_relative 'controller_list'
require_relative '../View/terminal_view_department_list'

class Controller_department_list < Controller_list
  public_class_method :new

  def initialize
    @list = Department_list.new
    @list.read_DB
    @view_list = Terminal_view_department_list.new(self)
  end

  def show_list
    puts @list
  end

  def choose_instance(num)
    @list.choose(num)
  end

  def close
    exit
  end

  def show_view
      ans = ''
      while ans != '0'
        puts "\n************Меню*************",
             '1. Отобразить список отделов',
             '2. Выбрать отдел',
             '3. Добавить отдел',
             '0. Завершить работу'
        print 'Ответ:'
        ans = gets.chomp
        case ans
        when '1'
          puts "\n========Отделы======="
          show_list
        when '2'
          print 'Введите номер отдела:'
          num = gets.chomp.to_i
          @instance = choose_instance(num)
          if @instance.class == Department
            puts @instance
          else
            puts 'Отдела с таким номером нет'
          end
        when '0'
          close
        else
          puts 'Такого пункта нет'
        end
      end
  end
end