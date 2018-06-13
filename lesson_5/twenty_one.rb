require 'pry'

class Participant
  LIMIT = 21
  attr_reader :cards, :name

  def initialize
    @cards = []
    @has_stayed = false
    @name = nil
  end

  def hit(new_card)
    puts "#{name} choses to hit!"
    receive_card(new_card)
    puts "#{name} gets #{new_card}"
    puts ""
  end

  def stay
    self.has_stayed = true
    puts "#{name} decides to stay."
    puts ""
  end

  def busted?
    total > LIMIT
  end

  def stays?
    has_stayed == true
  end

  def receive_card(new_card)
    cards << new_card
  end

  def show_cards
    cards.map(&:to_s).join(', ')
  end

  def total
    total = cards.map(&:value).sum
    aces_count = cards.map(&:face).count(:ace)
    total -= (aces_count * 10) if total > LIMIT
    total
  end

  private

  attr_accessor :has_stayed
end

class Player < Participant
  NAME = "Player"

  def initialize
    super()
    @name = NAME
  end

  def to_s
    cards.first(2).map(&:to_s).join(', ')
  end

  def decide
    puts "Do you want to hit or stay? press H for Hit, S for Stay"
    answer = nil
    loop do
      answer = gets.chomp
      break if %w[h s].include?(answer.downcase)
      puts "Wrong choice, please provide H or S"
    end
    true if answer == 'h'
  end
end

class Dealer < Participant
  NAME = "Dealer"
  HIT_LIMIT = 17

  def initialize
    super()
    @name = NAME
  end

  def to_s
    cards.first.to_s
  end

  def continues_to_hit?
    total < HIT_LIMIT
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = init_deck
  end

  def pick_card
    cards.delete(cards.sample)
  end

  private

  def init_deck
    faces = [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king, :ace]
    colors = %w[hearts diamonds clubs spades].map(&:to_sym)
    colors.each_with_object([]) do |color, deck|
      faces.each { |face| deck << Card.new(color, face) }
    end
  end
end

class Card
  FIGURE_VALUE = 10
  ACE_VALUE = 11
  CARD_VALUES = { jack: FIGURE_VALUE, queen: FIGURE_VALUE, king: FIGURE_VALUE,
                  ace: ACE_VALUE }

  attr_reader :color, :face
  attr_accessor :value

  def to_s
    "#{face} of #{color}"
  end

  def initialize(color, face)
    @color = color
    @face = face
    @value = set_value
  end

  private

  def set_value
    CARD_VALUES.keys.include?(face) ? CARD_VALUES[face] : face
  end
end

class Game
  # attr_reader :player, :dealer, :deck

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
    @winner = nil
  end

  def start
    loop do
      init_game
      play_game
      show_cards
      show_result
      break unless play_again?
    end
    puts "C'est fini le Black Jack!"
  end

  private

  attr_accessor :winner, :deck, :player, :dealer

  def init_game
    reset
    clear
    deal_cards
    show_initial_cards
  end

  def play_game
    loop do
      player_turn
      break opponent_wins(dealer) if player.busted?
      dealer_turn
      break opponent_wins(player) if dealer.busted?
      break compare_cards if player.stays? && dealer.stays?
    end
  end

  def player_turn
    choice = player.decide
    choice ? player.hit(deck.pick_card) : player.stay
  end

  def dealer_turn
    dealer.continues_to_hit? ? dealer.hit(deck.pick_card) : dealer.stay
  end

  def show_initial_cards
    puts "Player has #{player}"
    puts "Dealer has #{dealer}"
    puts ""
  end

  def deal_cards
    2.times { player.receive_card(deck.pick_card) }
    2.times { dealer.receive_card(deck.pick_card) }
  end

  def show_cards
    puts "Player had those cards: #{player.show_cards}"
    puts "Dealer had those cards: #{dealer.show_cards}"
    puts ""
  end

  def show_result
    return puts "It's a tie!" if no_bust? && !winner
    puts "Congratulations, #{winner.name}, you win."
    puts ""
  end

  def compare_cards
    puts "The dealer and player both stayed. It's time to compare cards."
    puts ""
    return self.winner = player if player.total > dealer.total
    return self.winner = dealer if dealer.total > player.total
    nil
  end

  def no_bust?
    player.busted? && dealer.busted?
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

  def opponent_wins(opponent)
    self.winner = opponent
  end

  def clear
    system 'clear'
  end

  def reset
    self.deck = Deck.new
    self.player = Player.new
    self.dealer = Dealer.new
    self.winner = nil
  end
end

Game.new.start
