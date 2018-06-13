require 'Time'

class Vehicle

  attr_accessor :speed, :color
  attr_reader :year, :model

  @@count = 0

  def self.created
    @@count
  end

  def initialize(year, color, model)
    @@count += 1
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def speed_up
    self.speed += 10
  end

  def brake
    self.speed -= 10
  end

  def shut_off
    self.speed = 0
  end

  def spray_paint(new_color)
    self.color = new_color
    puts "Your new #{color} paint job looks great!"
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def to_s
    "is a #{model} from #{year} in #{color} color. It is #{age} years old"
  end

  private

  def age
    now = Time.now.year
    now - year
  end

end
