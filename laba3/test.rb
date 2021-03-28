class Module
     def attr1(symbol)
            instance_var = ('@' + symbol.to_s)
            define_method(symbol) { instance_variable_get(instance_var) }  
     define_method(symbol.to_s + "=") { |val| instance_variable_set(instance_var, val) }
     end
     def attr2(symbol)
          module_eval "def #{symbol}; @#{symbol}; end"
          module_eval "def #{symbol}=(val); @#{symbol} = val; end"
     end
end

class Person
      attr_accessor :name
      # attr1 :name
      attr2 :phone
end
person = Person.new
person.name = 'John Smith'
person.phone = '555-2344'
puts person.name


# Бабина Наталья Алексеевна
# 04.03.1996
# 79997465430
# Одесская 44, кв.56
# natasha@gmail.com
# 8951075032
# Экономист
# 0

# Лапунова Анна Александровна
# 14.09.1990
# 79286749021
# Февральская 55
# lapaanya@yandex.ru
# 2910945371
# Аудит
# 4
# Проектсервис-юг
# Внутренний аудитор
