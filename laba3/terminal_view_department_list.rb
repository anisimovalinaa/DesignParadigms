require_relative 'department_list'
require_relative 'db_work'
require_relative 'department'
require_relative 'post'
require_relative 'terminal_view_list'

class Terminal_view_department_list < Terminal_view_list

  def show_list
    puts @list
  end

  def add
    print 'Введите название отдела:'
    dep_name = gets.chomp
    DB_work.db_work.add_department(dep_name)
    dep = Department.new(dep_name)
    @list.add(dep)
  end

  def delete_instance
    @list.delete(@instance)
  end

  def add_post
    print 'Наименование должности:'
    name_post = gets.chomp
    print 'Фиксированная зарплата:'
    fixed_salary = gets.chomp.to_i
    print 'Ежемесячные надбавки:'
    premium = gets.chomp.to_i
    print 'Ежеквартальные выплаты:'
    quarterly = gets.chomp.to_i
    print 'Бонус:'
    bonus = gets.chomp.to_i
    post = Post.new(1, name_post, fixed_salary, premium, quarterly, bonus, dep)
    DB_work.db_work.add_post(post)
    @instance.add_post(post)
  end

  def show_instance
    puts @instance
  end

  def choose_instance(num)
    @list.choose(num)
  end

  def close
    exit
  end

  def show
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
          puts
          ans_dep = ''
          while ans_dep != '0'
            puts "\t#{@instance}",
                 "\t1. Отобразить список должностей",
                 "\t2. Добавить должность",
                 "\t3. Удалить отдел",
                 "\t0. Назад"
            print "\tОтвет:"
            ans_dep = gets.chomp
            case ans_dep
            when '1'
              puts "\t#{@instance.posts}"
            when '2'
              add_post
            when '3'
              delete_department
              break
            when '0'
              break
            end
          end
        else
          puts 'Отдела с таким номером нет'
        end
      when '3'
        add_department
      when '0'
        close
      end
    end
  end
end