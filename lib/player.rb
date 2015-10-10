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

  end

  def draw(deck)

  end

  def play_turn(deck)
    get_cards(deck)
    play_card(deck)
  end

  #in this version, you can only draw if you have no valid cards to play.
  def get_cards(deck)

  end

  def play_card(deck)

  end

end
