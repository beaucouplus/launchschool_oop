class Person
  attr_reader :phone_number

  def initialize(number)
    @phone_number = number
  end
end

person1 = Person.new(1234567899)
puts person1.phone_number

person1.phone_number = 9987654321
puts person1.phone_number

# This code defines a Person class with 2 methods.
# First, a initialize method takes a parameter number. This parameter is 
# assigned to the instance variable phone_number.
# Second, an attr_reader is defined. It creates a new method phone_number
# which returns the instance variable @phone_number
