require_relative 'UI'

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

  def play_turn(deck)
    move = Interface.choose_move(self, deck)
    if move = "draw"
      get_cards(deck)
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
