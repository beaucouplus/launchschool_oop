class Person

  attr_accessor :first_name, :last_name

  def initialize(name)
    @first_name = name
    @last_name = ''
  end

  def name
    complete_name
  end

  def name=(name)
    self.first_name, self.last_name = name.split
  end

  def complete_name
    first_name + ' ' + last_name
  end

  def shares_name_with?(other_person)
    self.name == other_person.name
  end

  def to_s
    name
  end

end



bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'


bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')
puts "The person's name is: #{bob}"
p bob.shares_name_with?(rob)