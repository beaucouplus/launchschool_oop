class Student

  attr_reader :name

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(student)
    private_grade > student.private_grade
  end

  protected
  def private_grade
    @grade
  end


end

joe = Student.new("Joe", 6)
p joe.name
bob = Student.new("Bob", 4)

puts "Well done!" if joe.better_grade_than?(bob)