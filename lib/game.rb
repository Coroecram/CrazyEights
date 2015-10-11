require_relative 'card'
require_relative 'deck.rb'
require_relative 'player.rb'
require 'byebug'

class CrazyEightsGame

  def initialize(*players)
    @players = players
    raise "this game will be terrible" if players.count < 2
    @deck = Deck.new
    @interface = Interface.new
    @deck.show_top_card
  end

  def deal_to_players
    until @players.all? { |player| player.hand_size == 8 }
      @players.each { |player| player.draw(@deck) }
    end
  end

  def play
    deal_to_players
    until over?
      system("clear")
      system('cls')  # windows
      @interface.choose_move(current_player, @deck)
      next_turn
    end
    puts "Game over!"
  end

  def current_player
    @players.first
  end

  def next_turn
    @players.rotate!
  end

  def over?
    count = 0
    @players.each do |player|
      count += 1 if  player.hand_size > 0
    end
    return true if count == 1

  end

end


if $PROGRAM_NAME == __FILE__
  player1 = Player.new("Sennacy")
  player2 = Player.new("Whiskers")
  game = CrazyEightsGame.new(player1, player2)
  game.play
end
