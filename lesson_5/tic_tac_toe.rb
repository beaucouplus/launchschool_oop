require 'pry'
class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [2, 5, 8],
                   [3, 6, 9], [3, 5, 7], [1, 4, 7], [1, 5, 9]]

  attr_reader :squares
  def initialize
    @squares = reset
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts  "     |     |"
    puts  "  #{squares[1]}  |  #{squares[2]}  |  #{squares[3]}"
    puts  "     |     |"
    puts  "-----|-----|-----"
    puts  "     |     |"
    puts  "  #{squares[4]}  |  #{squares[5]}  |  #{squares[6]}"
    puts  "     |     |"
    puts  "-----|-----|-----"
    puts  "     |     |"
    puts  "  #{squares[7]}  |  #{squares[8]}  |  #{squares[9]}"
    puts  "     |     |"
    puts ""
  end
  # rubocop:enable Metrics/AbcSize

  def []=(position, marker)
    squares[position].marker = marker
  end

  def unmarked_positions
    # binding.pry
    squares.keys.select { |position| squares[position].unmarked? }
  end

  def full?
    unmarked_positions.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def marker_wins?(line, candidate)
    markers_in(line).map(&:marker).count(candidate) == 3
  end

  def markers_in(line)
    squares.values_at(*line)
  end

  def winning_marker
    WINNING_LINES.each do |line|
      next nil if markers_in(line).all?(&:unmarked?)
      candidate = markers_in(line).find(&:marked?).marker
      return candidate if marker_wins?(line, candidate)
    end
    nil
  end

  def reset
    (1..9).each_with_object({}) { |num, hsh| hsh[num] = Square.new }
  end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker
  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker
  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_player = human
  end

  def play
    clear
    display_welcome_message
    loop do
      display_board
      loop do
        self.current_player = alternate_player
        current_player_moves
        break if board.someone_won? || board.full?
        clear_and_display_board if human_turn?
      end
      display_result
      break unless play_again?
      reset
      display_play_again_message
    end
    display_goodbye_message
  end

  private

  attr_accessor :current_player

  def display_welcome_message
    puts "Welcome to Tic Tac Toe"
    puts ""
  end

  def display_goodbye_message
    puts "Goodbye. Thanks for playing."
  end

  def clear_and_display_board
    clear
    display_board
  end

  def display_board
    display_markers
    board.draw
  end

  def current_player_moves
    current_player == human ? human_moves : computer_moves
  end

  def alternate_player
    current_player == human ? computer : human
  end

  def human_moves
    puts "Choose a square between #{board.unmarked_positions.join(', ')}"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_positions.include?(square)
      puts "Sorry. It's not a valid choice"
    end
    board[square] = human.marker
    board[1] = 
  end

  def computer_moves
    board[board.unmarked_positions.sample] = computer.marker
  end

  def display_result
    clear_and_display_board
    case board.winning_marker
    when human.marker
      puts "You won"
    when computer.marker
      puts "Computer won."
    else
      puts "It's a tie."
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again?"
      answer = gets.chomp.downcase
      break if %w[y n].include? answer
      puts 'Sorry, must be y or n'
    end
    true if answer == 'y'
  end

  def clear
    system 'clear'
  end

  def reset
    @board = Board.new
    self.current_player = human
    clear
  end

  def display_play_again_message
    puts "Let's play again"
    puts ""
  end

  def display_markers
    puts "You're a #{human.marker}. Computer is a #{computer.marker}"
    puts ""
  end

  def human_turn?
    current_player == human
  end
end

# we'll kick off the game like this
game = TTTGame.new
game.play
