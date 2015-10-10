require_relative 'card'

# Represents a deck of playing cards.
class Deck
  # Returns an array of all 52 playing cards.
  def self.all_cards

  end

  def initialize(cards = Deck.all_cards)
    @cards = cards
  end

  # Returns the number of cards in the deck.
  def count
  end

  def shuffle

  end

  def last_discarded

  end

  # Takes a card from the top of the deck, returns a card.
  def draw

  end

  # Allow players to place cards on the discard pile
  def discard(card)

  end

  # puts top card of the deck in the discard pile
  def show_top_card

  end
end
