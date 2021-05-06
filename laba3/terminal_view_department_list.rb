require_relative 'department_list'
require_relative 'db_work'
require_relative 'department'
require_relative 'post'

class Terminal_view_department_list
  @@department_list = Department_list.new

  def self.show_list
    puts @@department_list
  end


  def self.add_department(dep_name)
    DB_work.db_work.add_department(dep_name)
    dep = Department.new(dep_name)
    @@department_list.add(dep)
  end

  def self.add_post(dep)
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
    dep.add_post(post)
  end

  def self.show
    @@department_list.read_DB
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
        dep = @@department_list.choose(num)
        if dep.class == Department
          puts
          ans_dep = ''
          while ans_dep != '0'
            puts "\t#{dep}",
                 "\t1. Отобразить список должностей",
                 "\t2. Добавить должность",
                 "\t0. Назад"
            print "\tОтвет:"
            ans_dep = gets.chomp
            case ans_dep
            when '1'
              puts "\t#{dep.posts}"
            when '2'
              add_post(dep)
            when '0'
              break
            end
          end
        else
          puts 'Отдела с таким номером нет'
        end
      when '3'
        print 'Введите название отдела:'
        dep_name = gets.chomp
        add_department dep_name
      when '0'
        exit
      end
    end
  end
end