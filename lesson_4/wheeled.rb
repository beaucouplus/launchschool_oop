module Fuelable
  attr_accessor :speed, :heading
  attr_reader :fuel_efficiency, :fuel_capacity

  def range
    fuel_efficiency * fuel_capacity
  end

end

class WheeledVehicle
  include Fuelable

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end

end

class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end

class Boat
  include Fuelable
  attr_accessor :propeller_count, :hull_count
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
    @propeller_count = num_propellers
    @hull_count = num_hulls
  end

  def range
    super + 10
  end

end

class Catamaran < Boat
end

class MotorBoat < Boat
  def initialize(bim, bam)
    super(1, 1, bim, bam)
  end
end

car = Auto.new
p car.range

cat = Catamaran.new(3, 5, 40, 40)
p cat.range

boat = MotorBoat.new(50,40)
p boat.range
