require_relative 'terminal_view_instance'

class Terminal_view_department_instance < Terminal_view_instance
  def show_instance
    @controller_instance.show_instance
  end

  def show
    ans = ''
    while ans != '0'
      puts
      puts '1. Вывести отдел.', '0. Назад'
      print 'Введите ответ:'
      ans = gets.chomp
      case ans
      when '1'
        print 'Текущий отдел: '
        show_instance
      when '0'
        break
      else
        'Такого пункта нет'
      end
    end
  end
end