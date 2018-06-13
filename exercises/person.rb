class Person

  def secret=(secret)
    @secret = secret
  end

  def secret
    @secret
  end
end



person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
puts person1.secret