require 'card'
require 'deck'

describe Deck do
  describe "::all_cards" do
    subject(:all_cards) { Deck.all_cards }

    it "starts with a count of 52" do
      expect(all_cards.count).to eq(52)
    end

    it "returns all cards without duplicates" do
      deduped_cards = all_cards
        .map { |card| [card.suit, card.value] }
        .uniq
        .count
      expect(deduped_cards).to eq(52)
    end
  end

  let(:cards) do
    cards = [
      Card.new(:spades, :king),
      Card.new(:spades, :queen),
      Card.new(:spades, :jack)
    ]
  end

  describe "#initialize" do
    it "by default fills itself with 52 cards" do
      deck = Deck.new
      expect(deck.count).to eq(52)
    end

    it "can be initialized with an array of cards" do
      deck = Deck.new(cards)
      expect(deck.count).to eq(3)
    end
  end

  let(:deck) do
    Deck.new(cards.dup)
  end

  it "does not expose its cards directly" do
    expect(deck).not_to respond_to(:cards)
  end

  it "has a discard pile" do
    expect(deck.discard_pile).to eq([])
  end

  describe "#draw" do

    #it expects the last card to be drawn or popped from the deck
    it "returns a card from the deck" do
      deck = Deck.new
      expect(deck.draw.class).to eq(Card)
    end


    it "removes cards from deck on take" do
      deck = Deck.new
      deck.draw
      expect(deck.count).to eq(51)
    end

    it "doesn't allow you to take more cards than are in the deck" do
      expect do
        4.times { deck.draw }
      end.to raise_error("not enough cards")
    end
  end


  describe "#discard" do

    it "adds a card to the discard pile" do
      deck = Deck.new
      card1 = Card.new(:spades, :king)
      deck.discard(card1)
      expect(deck.discard_pile).to eq([card1])
    end

  end

  describe "#show_top_card" do

    deck = Deck.new
    deck.show_top_card

    it "removes a card from the deck" do
      expect(deck.count).to eq(51)
    end

    it "adds a card to the discard pile" do
      expect(deck.discard_pile.count).to eq(1)
    end

  end

  describe "#last_discarded" do

    it "returns a card" do
      deck = Deck.new
      deck.show_top_card
      expect(deck.last_discarded.class).to eq(Card)
    end

    it "returns the last discarded card" do
      deck = Deck.new
      card1 = Card.new(:spades, :king)
      card2 = Card.new(:hearts, :queen)
      deck.discard(card1)
      deck.discard(card2)
      expect(deck.last_discarded).to eq(card2)
    end

  end

  describe "#shuffle" do

    it "changes the order of the cards in the deck" do
      deck = Deck.new
      card1 = deck.draw
      deck = Deck.new
      deck.shuffle
      card2 = deck.draw
      expect(card1).not_to eq(card2)
    end

  end

end
