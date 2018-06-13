class Vehicle
  attr_reader :make, :model
  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle
  def wheels
    4
  end
end

class Motorcycle < Vehicle
  def wheels
    2
  end  
end

class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end
end
# Refactor these classes so they all use a common superclass, and inherit
# behavior as needed.
car = Car.new("renault", "twingo")
moto = Motorcycle.new("mitsu", "bichi")
truck = Truck.new("mercedes", "benzor", 17)

puts car 
puts moto
puts truck
puts truck.payload