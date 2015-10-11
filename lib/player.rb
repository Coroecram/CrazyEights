require_relative 'UI'
require_relative 'card'
require 'byebug'

class Player
  attr_reader :name
  attr_accessor :hand

  def initialize(name, interface = Interface.new)
    @name = name
    @hand = []
    @interface = interface
  end

  def hand_size
    hand.count
  end

  def draw(deck)
      hand << deck.draw
  end

  def draw_check(deck)
    if has_play?
      raise PlayError.new "Cannot draw with a valid play available."
    else
      draw(deck)
      raise PlayError.new "You drew a #{hand.last}!"
    end
  end

  def play_turn(deck)
    move = @interface.choose_move(self, deck)
    if move == "draw"
      #get_cards(deck)
    else
      play_card(move)
    end
  end

  #in this version, you can only draw if you have no valid cards to play.
  def get_cards(deck)
    draw(deck)
  end

  def play_card(card)


  end

  def valid_card?(card_val, deck)
    hand.each do |card|
      return card if card.string_value == card_val && card.suit == deck.last_discarded.suit
      return card if card.string_value == card_val && card_val == '8'
    end

    nil
  end

  def has_play?
    false
  end

  def crazy?
    self.value == :eight
  end

  def crazy_eights
  end

  def set_suit(crazy_eight)
    begin
      puts "What would you like to set the suit to?"
      new_suit = gets.chomp
      Card.suits.include?(new_suit)
    rescue
      retry
    end
    true
  end

end

class PlayError < ArgumentError
end
