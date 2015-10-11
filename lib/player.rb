require_relative 'UI'
require_relative 'card'
require 'byebug'

class Player
  attr_reader :name
  attr_accessor :hand

  def initialize(name)
    @name = name
    @hand = []
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
        return suits_check(card) if card.string_value == card_val && card.value == deck.last_discarded.value
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
    deck.discard(Card.new(set_suit, :suit_changer))
  end

  #in case you have more than 1 card of the same value and want to select of which suit to play
  def suits_check(possible_card)
    suits = []
    hand.each do |card|
      suits << card.suit if card.value == possible_card.value
    end
    if suits.count > 1
      puts "Which suit of #{possible_card.value}: suits.join(", ")?"
      suit = gets.chomp.to_sym
      raise NoSuitError.new "That is not a valid suit" unless Card.suits.include?(new_suit)
      suit_pick(possible_card.value, suit)
    else
    end
  rescue NoSuitError => e
    puts e.message
    sleep 1.5
    retry
  rescue NoCardError => e
    puts e.message
    sleep 1.5
    retry
  end

  def suit_pick(value, suit)
    hand.each do |card|
      return card if card.value == value && card.suit == suit
    end

    raise NoCardError.new "You do not have a #{value} of #{suit}."
  end

  def set_suit(value = nil)
    puts "What would you like to set the suit to?"
    new_suit = gets.chomp.to_sym
    raise NoSuitError.new "That is not a valid suit" unless Card.suits.include?(new_suit)
    return suit_pick(value, new_suit) unless value == nil
    return new_suit
  rescue NoSuitError => e
    puts e.message
    sleep 1.5
    retry
  end

end

class HasPlayError < ArgumentError
end

class NoPlayError < ArgumentError
end

class NoCardError < ArgumentError
end

class NoSuitError < ArgumentError
end
