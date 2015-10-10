require_relative 'card'

# Represents a deck of playing cards.
class Deck
  attr_reader :discard_pile
  # Returns an array of all 52 playing cards.
  def self.all_cards
    all_cards = []

    Card.suits.each do |suit|
      Card.values.each do |value|
        all_cards << Card.new(suit, value)
      end
    end

    all_cards
  end

  def initialize(cards = Deck.all_cards)
    @cards = cards
    @discard_pile = []
  end

  # Returns the number of cards in the deck.
  def count
    @cards.count
  end

  def shuffle
    @cards.shuffle!
  end

  def last_discarded
    @discard_pile.last
  end

  # Takes a card from the top of the deck, returns a card.
  def draw
    raise "not enough cards" if count == 0
    @cards.pop
  end

  # Allow players to place cards on the discard pile
  def discard(card)
    @discard_pile << card
  end

  # puts top card of the deck in the discard pile
  def show_top_card
    card = draw
    discard(card)
  end
end
