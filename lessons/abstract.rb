class Main
  def template
    puts_a
    puts_b
    puts_c
  end
  def puts_a
    raise FloatDomainError
  end

  def puts_b
    raise ArgumentError
  end

  def lala
    puts 'lala'
  end

  def puts_c
    raise ArgumentError
  end
end

class Child < Main
  def puts_a
    puts 'a'
  end

  def puts_b
    puts 'b'
  end

  def puts_c
    puts 'c'
  end
end

obj = Child.new
# obj.puts_b
obj.template