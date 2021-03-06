# Rock, Paper, Scissors is a two-player game where each player chooses
# one of three possible moves: rock, paper, or scissors. The chosen moves
# will then be compared to see who wins, according to the following rules:

# - rock beats scissors
# - scissors beats paper
# - paper beats rock

# If the players chose the same move, then it's a tie.

# Nouns: player, move, rule
# Verbs: choose, compare

class Player
  attr_accessor :move, :name, :score, :moves

  def initialize
    set_name
    @score = 0
    @moves = []
  end

  def wins_game?
    score >= 3
  end

  def add_move
    moves << move.to_s
  end


end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts 'Sorry, please enter something'
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose Rock, Paper, or Scissors:"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts 'Sorry,invalid choice'
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  attr_reader :human_moves

  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Capsule'].sample
  end

  def choose
    self.move = Move.new(choose_best_move.sample)
  end

  def spy(human_moves)
    @human_moves = human_moves
  end

  def choose_best_move
    return Move::VALUES if human_moves.size < 2
    moves_count = Move::VALUES.each_with_object({}) do |value,hsh|
      hsh[value] = human_moves.count(value)
    end
    moves_count.reject { |move, count| count == moves_count.values.max }.keys
  end

end

class Move
  VALUES = ['rock', 'paper', 'scissors']

  def to_s
    @value
  end

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?)  ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    rock? && other_move.paper? ||
      paper? && other_move.scissors? ||
      scissors? && other_move.rock?
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
    computer.spy(human.moves)
  end

  def display_welcome_message
    puts "Welcome to Rock Paper Scissors"
  end

  def display_goodbye_message
    puts "Goodbye fellow player"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def display_winner
    if human.move > computer.move
      human.score += 1
      human.add_move
      puts "#{human.name} won."
    elsif human.move < computer.move
      computer.score += 1
      puts "#{computer.name} won"
    else
      puts "it's a tie"
    end
    player_score = "Current score: #{human.name} #{human.score}"
    computer_score = "#{computer.name} #{computer.score}"
    puts player_score + ' - ' + computer_score
  end

  def display_set_winner
    return "#{human.name} wins. Game over" if human.wins_game?
    "#{computer.name} wins. Game over"
  end


  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      puts display_set_winner if someone_wins_game?
      break if someone_wins_game?
      break unless play_again?
    end
    display_goodbye_message
  end

  def someone_wins_game?
    human.wins_game? || computer.wins_game?
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again ? y/n"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts 'Sorry, you did not enter y or n'
    end
    return true if answer == 'y'
    false
  end


end

game = RPSGame.new
game.play
