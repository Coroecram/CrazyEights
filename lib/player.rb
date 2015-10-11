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
      print " | #{card} |  "
    end
    puts
  end

  def draw_check(deck)
    if has_play?(deck)
      raise PlayError.new "Cannot draw with an available play."
    else
      draw(deck)
      raise PlayError.new "You drew a #{hand.last}!"
    end
  end

  #in this version, you can only draw if you have no valid cards to play.
  def get_cards(deck)
    draw(deck)
  end

  def valid_card?(card_val, deck)
    hand.each do |card|
      return card if card.string_value == card_val && card.suit == deck.last_discarded.suit
      return card if card.string_value == card_val && card.crazy?
    end

    nil
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
    # byebug
    deck.discard(Card.new(set_suit, :suit_changer))
  end

  def set_suit
    puts "What would you like to set the suit to?"
    new_suit = gets.chomp.to_sym
    raise NoSuitError.new "That is not a valid suit" unless Card.suits.include?(new_suit)
    return new_suit
  rescue NoSuitError => e
    puts e.message
    sleep 1.5
    retry
  end

end

class PlayError < ArgumentError
end

class NoSuitError < ArgumentError
end
