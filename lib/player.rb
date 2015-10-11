require_relative 'UI'
require_relative 'card'
require 'byebug'

class Player
  attr_reader :name, :interface
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

  def show_hand
    hand.each_with_index do |card, idx|
      puts "\n\n" if idx % 5 == 0
      print "#{card}"
    end
    puts
  end

  def draw_check(deck)
    if has_play?(deck)
      raise HasPlayError.new "Cannot draw with an available play."
    else
      draw(deck)
      raise NoPlayError.new "You drew a #{hand.last}!"
    end
  end

  #in this version, you can only draw if you have no valid cards to play.
  def get_cards(deck)
    draw(deck)
  end

  def valid_card?(card_val, deck)
    if card_val == "draw"
      draw_check(deck)
    else
      hand.each do |card|
        return card if card.string_value == card_val && card.suit == deck.last_discarded.suit
        return card if card.string_value == card_val && card.crazy?
        return interface.suits_check(self, card) if card.string_value == card_val && card.value == deck.last_discarded.value
      end
    end

    raise NoCardError.new "That is not a card you can play."
  end

  def has_play?(deck)
    hand.each do |card|
      return true if card.same_value?(deck.last_discarded) || card.same_suit?(deck.last_discarded)
      return true if card.value == :eight
    end

    false
  end

  def play_card(card, deck)
    return crazy_eights(card, deck) if card.crazy?
    hand.delete(card)
    deck.discard(card)
  end

  def crazy_eights(eight, deck)
    hand.delete(eight)
    deck.discard(eight)
    deck.discard(Card.new(interface.set_suit, :suit_changer))
  end



  def available_suits(possible_card)
    suits = []
    hand.each do |card|
      suits << card.suit if card.value == possible_card.value
    end
    suits
  end

  def suit_pick(value, suit)
    hand.each do |card|
      return card if card.value == value && card.suit == suit
    end
  end



end

class HasPlayError < ArgumentError
end

class NoPlayError < ArgumentError
end
