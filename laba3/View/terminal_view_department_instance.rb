class Terminal_view_department_instance
  def show
    ans = ''
    while ans != '0'
      puts '1. Вывести отдел.', '0. Назад'
      print 'Введите ответ:'
      ans = gets.chomp
    end
  end
end