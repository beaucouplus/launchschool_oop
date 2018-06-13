class GuessingGame

  attr_reader :valid_guesses
  def initialize(low_value = 1, high_value = 100)
    @valid_guesses = (low_value..high_value).to_a
  end


  # VALID_GUESSES = (1..100).to_a
  MAX_GUESSES = 7
  attr_accessor :guess, :guesses
  attr_reader :number_to_find

  def play
    loop do
      reset
      loop do
        take_user_input
        self.guesses -= 1
        display_error_message if number_not_found?
        break puts "You win!" if number_found?
        break puts "You are out of guesses. You lose." if guesses <= 0
      end
      break
    end
  end

  private

  def take_user_input
    puts "You have #{guesses} guesses remaining."
    puts ""
    puts "Enter a number between #{valid_guesses.first} and #{valid_guesses.last}:"
    puts ""
    loop do
      self.guess = gets.chomp.to_i
      break if valid_guess?
      puts "Invalid guess. Enter a number between #{valid_guesses.first} and #{valid_guesses.last}:"
    end
  end

  def reset
    @guess = nil
    @guesses = Math.log2(valid_guesses.size).to_i + 1
    @number_to_find = valid_guesses.sample
  end

  def valid_guess?
    valid_guesses.include?(guess)
  end

  def display_error_message
    puts "Your guess is too low\n" if guess < number_to_find
    puts "Your guess is too high\n" if guess > number_to_find
  end

  def number_not_found?
    guess != number_to_find
  end

  def number_found?
    guess == number_to_find
  end

end


game = GuessingGame.new(100, 1200)
game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 104
# Invalid guess. Enter a number between 1 and 100: 50
# Your guess is too low

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 75
# Your guess is too low

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 85
# Your guess is too high

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 0
# Invalid guess. Enter a number between 1 and 100: 80

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 81
# You win!

# game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 50
# Your guess is too high

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 25
# Your guess is too low

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 37
# Your guess is too high

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 31
# Your guess is too low

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 34
# Your guess is too high

# You have 2 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low

# You have 1 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low
# You are out of guesses. You lose.
