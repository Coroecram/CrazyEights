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
    @hand.size
  end

  def draw(deck)
    @hand << deck.draw
  end

  def play_turn(deck)
    get_cards(deck)
    play_card(deck)
  end

  #in this version, you can only draw if you have no valid cards to play.
  def get_cards(deck)
    last_card = deck.last_discarded
    until @hand.any? { |card| card.valid_match?(last_card) }
      puts "Uh oh, no valid cards. You must draw"
      @interface.show_hand(self)
      draw(deck)
    end
  end

  def play_card(deck)
    card = @interface.choose_card(self)
    if card.valid_match?(deck.last_discarded)
      @hand.delete(card)
      if card.crazy?
        suit = @interface.choose_suit
        card.set_suit(suit)
      end
      deck.discard(card)
    else
      raise 'invalid match!'
    end
  end

end
