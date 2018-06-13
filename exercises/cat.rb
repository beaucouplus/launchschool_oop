module Walkable
  def walk
    puts "Let's go for a walk!"
  end
end

class Cat
  include Walkable
  attr_accessor :name

  COLOR = 'green'.freeze

  @@cat_count = 0
  def initialize(name)
    @@cat_count += 1
    @name = name
  end

  def self.total
    puts  @@cat_count
  end


  def greet
    puts "Hello, my name is #{name} and I'm #{COLOR}!"
  end

  def rename(new_name)
    self.name = new_name
  end

  def self.generic_greeting
    puts "Hello I'm a cat!"
  end

  def personal_greeting
    puts "Hello, I'm not any cat, I'm #{name}"
  end

  def identify
    p self
  end

  def to_s
    "I'm #{name}"
  end

end

kitty = Cat.new('Sophie')
kitty.identify
kitty.greet
kitty.walk
kitty.rename('Albatard')
p kitty.name
Cat.generic_greeting
kitty.personal_greeting
bom = Cat.new("egard")
neom = Cat.new("Nila")
Cat.total
puts kitty
