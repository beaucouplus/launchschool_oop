require_relative 'vehicle'
require_relative 'arrestable'

class MyCar < Vehicle
  include Arrestable
  DIFFERENCE = "4 wheels and tiny size"

  attr_reader :model

  def self.difference 
    DIFFERENCE
  end

  def initialize(year, color, model)
    super
  end

  def to_s
    "My car" + super
  end

end

class MyTruck < Vehicle
  DIFFERENCE = "4 wheels and big size"

  def self.difference 
    DIFFERENCE
  end

  def to_s
    "My truck" + super
  end

end

fiat = MyCar.new(1991, "yellow", "Fiat Panda")
renault = MyCar.new(1998, "red", 'R5')
monster = MyTruck.new(2008, "blue", "Monster Truck")
puts fiat
p fiat.color
p fiat.year
fiat.color = "bordeaux"
p fiat.color
p fiat.spray_paint("blue")
p MyCar.gas_mileage(100, 100)

monster.spray_paint("red")
p monster.color
"---------"
puts MyCar.difference
puts MyTruck.difference
"----------"
puts MyCar.created
puts fiat.arrest

puts MyCar.ancestors
puts MyTruck.ancestors
