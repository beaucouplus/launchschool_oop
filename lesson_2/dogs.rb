class Pet
  def speak
    'makes some noise'
  end

  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet

  def speak
    'bark'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Cat < Pet

  def speak
    'meow'
  end

end

class BullDog < Dog

  def swim
    "can't swim"
  end

end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"

bull = BullDog.new
puts bull.swim

meow = Cat.new
puts meow.speak

puts Cat.ancestors