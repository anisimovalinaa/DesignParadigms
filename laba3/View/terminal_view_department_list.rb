require_relative '../Model/department_list'
require_relative '../db_work'
require_relative '../Model/department'
require_relative '../Model/post'
require_relative 'terminal_view_list'

class Terminal_view_department_list < Terminal_view_list

  def show_list
    @controller_list.show_list
  end

  def add
    @controller_list.add
  end

  def delete_instance
    @controller_list.delete_instance
  end

  # def add_post
  #   print 'Наименование должности:'
  #   name_post = gets.chomp
  #   print 'Фиксированная зарплата:'
  #   fixed_salary = gets.chomp.to_i
  #   print 'Ежемесячные надбавки:'
  #   premium = gets.chomp.to_i
  #   print 'Ежеквартальные выплаты:'
  #   quarterly = gets.chomp.to_i
  #   print 'Бонус:'
  #   bonus = gets.chomp.to_i
  #   post = Post.new(1, name_post, fixed_salary, premium, quarterly, bonus, dep)
  #   DB_work.db_work.add_post(post)
  #   @instance.add_post(post)
  # end
  #
  # def show_instance
  #   puts @instance
  # end
  #
  def choose_instance(num)
    @controller_list.choose_instance
  end

  def close
    @controller_list.close
  end

  def show
    ans = ''
    while ans != '0'
      puts "\n************Меню*************",
           '1. Отобразить список отделов',
           '2. Выбрать отдел',
           '3. Добавить отдел',
           '4. Удалить выбранный отдел',
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
      when '3'
        add
        puts 'Добавление прошло успешно'
      when '4'
        if @instance != nil
          delete_instance
          puts 'Удаление прошло успешно'
        else
          puts 'Вы не выбрали отдел'
        end
      when '0'
        close
      else
        puts 'Такого пункта нет'
      end
    end
  end
end