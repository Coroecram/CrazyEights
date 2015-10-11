require 'colorize'
#comment in for fun colors!

# -*- coding: utf-8 -*-

# Represents a playing card.
class Card
  SUIT_STRINGS = {
    :clubs    => "♣",
    :diamonds => "♦",
    :hearts   => "♥",
    :spades   => "♠"
  }

  VALUE_STRINGS = {
    :suit_changer => "New suit: ",
    :deuce => "2",
    :three => "3",
    :four  => "4",
    :five  => "5",
    :six   => "6",
    :seven => "7",
    :eight => "8",
    :nine  => "9",
    :ten   => "10",
    :jack  => "J",
    :queen => "Q",
    :king  => "K",
    :ace   => "A"
  }

  # VALUE_NUMBERS = {
  #   :suit_changer => 0,
  #   :ace   => 1,
  #   :deuce => 2,
  #   :three => 3,
  #   :four  => 4,
  #   :five  => 5,
  #   :six   => 6,
  #   :seven => 7,
  #   :eight => 8,
  #   :nine  => 9,
  #   :ten   => 10,
  #   :jack  => 11,
  #   :queen => 12,
  #   :king  => 13
  # }

  # Returns an array of all suits.
  def self.suits
    SUIT_STRINGS.keys
  end

  # Returns an array of all values.
  def self.values
    VALUE_STRINGS.keys
  end

  attr_reader :suit, :value

  def initialize(suit, value)
    unless Card.suits.include?(suit) && (Card.values.include?(value) || value == :suit_changer)
      raise "illegal suit (#{suit}) or value (#{value})"
    end

    @suit, @value = suit, value
  end

  #this should be pretty self explanatory.
  def same_suit?(other_card)
    self.suit == other_card.suit
  end

  #yep.
  def same_value?(other_card)
    self.value == other_card.value
  end

  def crazy?
    self.value == :eight
  end

  def string_value
    VALUE_STRINGS[value]
  end

  # def value_int(card)
  #   VALUE_NUMBERS[card.value]
  # end

  #if card can be played on top of the previous card in the discard pile
  def valid_match?(other_card)
    return true if value == :suit_changer
    return true if value == :ace
    return true if same_value?(other_card) || same_suit?(other_card)
    false
  end

  # def valid_place?(top_of_pile, card)
  #   (card.same_suit?(top_of_pile) && value_int(card) < value_int(top_of_pile))
  # end

  def to_s
    if suit == :hearts || suit == :diamonds
      "| ".colorize(:color => :black, :background => :white) + (VALUE_STRINGS[value] + SUIT_STRINGS[suit]).colorize(:color => :red, :background => :white) + " |".colorize(:color => :black, :background => :white) + " "
    else
      "| ".colorize(:color => :black, :background => :white) + (VALUE_STRINGS[value] + SUIT_STRINGS[suit]).colorize(:color => :black, :background => :white) + " |".colorize(:color => :black, :background => :white) + " "
    end
  end
end
