class Greeting
  def greet(text)
    puts text
  end
end

class Hello < Greeting
  def hi
    greet 'hello'
  end
end

class Goodbye < Greeting
  def bye
    greet "bye"
  end
end

hi = Hello.new
hi.hi
bye = Goodbye.new
bye.bye
