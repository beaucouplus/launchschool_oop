module Mailable
  attr_reader :name, :address, :city, :state, :zipcode

  def print_address
    puts "#{name}"
    puts "#{address}"
    puts "#{city}, #{state} #{zipcode}"
  end
end

class Customer
  include Mailable
end

class Employee
  include Mailable
end

betty = Customer.new
bob = Employee.new
betty.print_address
bob.print_address
