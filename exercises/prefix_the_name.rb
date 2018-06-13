# Using the following code, add the appropriate accessor methods so that @name
# is returned with the added prefix 'Mr.'.

class Person
  attr_reader :name
  def name=(name)
    @name = "Mr. " + name
  end
end

person1 = Person.new
person1.name = 'James'
puts person1.name