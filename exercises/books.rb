class Book
  attr_reader :author, :title
  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.

# This code defines a class Book on line 1
# It has 4 methods, 2 being created thanks to accessor methods.
# The first method on line 3 is initialize. It is called every times a new
# object is created, and here takes 2 arguments, author and title.
# 2 instance variables are defined. the author argument is assigned to @author,
# while the title argument is assigned to @title.
# the 2 accessor methods are defined on line 2. It defines 2 getter methods, 
# which return the instance variables @author and @title.

# The to_s method is defined on line 8. It overwrites the usual to_s method and
# allows to return a readable string of the object content. When the object is
# output with puts, puts always calls to_s so it now displays the local to_s
# method return value instead of the usual object name and id.

# on line 13, a new instance of book is created with 2 arguments: the author is 
# defined as "Neil Stephenson" and the title as "Snow Crash". This instance
# is assigned to the variable book

# On line 14, the puts method outputs a string which will output "The author
# of Snow Crash is Neil Stephenson." Because author and title are made available
# outside the class thanks to the 2 getters, they are output here. The puts method
# returns nil.
# On line 15, the puts methods displays "book = Snow Crash by Neil Stephenson"
# Since to_s is defined locally, it is called here string is interpolated.
# String interpolation always calls to_s on each object, so it works fine.
