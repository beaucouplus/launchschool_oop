class Owner
  attr_reader :name, :pets
  def initialize(name)
    @name = name
    @pets = []
  end

  def number_of_pets
    pets.size
  end

end

class Shelter
  def initialize
    @owners = {}
    @unadopted_pets = {}
  end

  def adopt(owner, pet)
    owners[owner.name] ||= owner
    owner.pets << pet
  end

  def number_of_unadopted_pets
    unadopted_pets.values.size
  end

  def print_adoptions
    owners.values.each do |owner|
      puts "#{owner.name} has adopted the following pets"
      owner.pets.each do |pet|
        puts "a #{pet.animal} named #{pet.name}"
      end
    end
  end

  def pickup(pet)
    unadopted_pets[pet.name] ||= pet
  end

  def print_unadopted_pets
    puts "The animal shelter has the following unadopted pets:"
    unadopted_pets.values.each do |pet|
      puts "a #{pet.animal} named #{pet.name}"
    end
  end

  private
  attr_reader :owners, :unadopted_pets

end

class Pet
  attr_reader :animal, :name
  def initialize(animal, name)
    @animal = animal
    @name = name
  end
end
butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

asta = Pet.new('dog', 'Asta')
laddie = Pet.new('dog', 'Laddie')
fluffy = Pet.new('cat', 'Fluffy')
kat = Pet.new('cat', 'Kat')
ben = Pet.new('cat', 'Ben')
chatterbox = Pet.new('parakeet', 'Chatterbox')
bluebell = Pet.new('parakeet', 'Bluebell')

shelter.pickup(asta)
shelter.pickup(laddie)
shelter.pickup(fluffy)
shelter.pickup(kat)
shelter.pickup(ben)
shelter.pickup(chatterbox)
shelter.pickup(bluebell)

shelter.print_unadopted_pets
puts "The animal shelter has #{shelter.number_of_unadopted_pets} unadopted pets."
# Write the classes and methods that will be necessary to make this code run,
# and print the following output:

# P Hanson has adopted the following pets:
# a cat named Butterscotch
# a cat named Pudding
# a bearded dragon named Darwin

# B Holmes has adopted the following pets:
# a dog named Molly
# a parakeet named Sweetie Pie
# a dog named Kennedy
# a fish named Chester

# P Hanson has 3 adopted pets.
# B Holmes has 4 adopted pets.
