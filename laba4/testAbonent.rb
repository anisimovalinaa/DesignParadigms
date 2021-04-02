require_relative 'abonents'

class TestAbonent < Abonent
  def to_s
    'Данные абонента: ' + super
  end

  def self.check_correct
    puts 'Что вы хотите проверить?', '1. ИНН.', '2. Телефон.', '3. Расчетный счет.', '0. Выйти.'
    ans = ''
    while ans != '0'
      print 'Ваш ответ: '
      ans = gets.chomp()
      case ans
      when '1'
        print 'Введите строку: '
        str = gets.chomp()
        begin
          puts convert_to_inn(str)
        rescue ArgumentError => e
          puts e.message
        end
      when '2'
        print 'Введите строку: '
        str = gets.chomp()
        begin
          puts convert_to_number(str)
        rescue ArgumentError => e
          puts e.message
        end
      when '3'
        print 'Введите строку: '
        str = gets.chomp()
        begin
          puts convert_to_bank_account(str)
        rescue ArgumentError => e
          puts e.message
        end
      when '0'
        puts 'До свидания.'
      else
        puts 'Такого пункта нет'
      end
    end
  end
end
