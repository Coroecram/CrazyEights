require 'card'
require 'player'

describe Player do
  subject(:player) do
    Player.new("Kush Patel", )
  end

  it "assigns the name" do
    expect(player.name).to eq("Kush Patel")
  end

  it "starts players with an empty hand" do
    expect(player.hand).to eq([])
  end

  describe "#draw" do
    let(:deck) { double("deck") }

    it "adds a card to the players hand" do
      allow(deck).to receive(:draw).and_return(:card)
      player.draw(deck)
      expect(player.hand).to eq([:card])
    end

  end

  describe "#get_cards" do

    let(:deck) { double("deck") }

    it "should draw a card if no cards in the hand are valid" do
      allow(deck).to receive(:draw).and_return(Card.new(:diamonds, :three))
      player.draw(deck)
      allow(deck).to receive(:draw).and_return(Card.new(:hearts, :three))
      allow(deck).to receive(:last_discarded).and_return(Card.new(:hearts, :king))
      player.get_cards(deck)
      expect(player.hand_size).to eq(2)
    end

    it "should do nothing if a valid match is in the current hand" do
      allow(deck).to receive(:draw).and_return(Card.new(:hearts, :three))
      player.draw(deck)
      allow(deck).to receive(:last_discarded).and_return(Card.new(:hearts, :king))
      player.get_cards(deck)
      expect(player.hand_size).to eq(1)
    end

  end

  describe "#play_card" do

    let(:deck) { double("deck") }
    let(:interface) { double("UI") }
    let(:card) { Card.new(:clubs, :eight) }

    it "should call the given '#choose_card' method." do
      allow(interface).to receive(:choose_card).and_return(Card.new(:clubs, :four))
      allow(interface).to receive(:choose_suit).and_return(:hearts)
      allow(deck).to receive(:discard)
      allow(deck).to receive(:last_discarded).and_return(Card.new(:diamonds, :four))
      player = Player.new("Frank", interface)
      expect(interface).to receive(:choose_card)
      player.play_card(deck)
    end

    it "should call the given '#choose_suit' method if the card is CRAZY." do
      allow(interface).to receive(:choose_card).and_return(Card.new(:clubs, :eight))
      allow(interface).to receive(:choose_suit).and_return(:hearts)
      allow(deck).to receive(:discard)
      allow(deck).to receive(:last_discarded).and_return(Card.new(:diamonds, :four))
      player = Player.new("Frank", interface)
      expect(interface).to receive(:choose_suit)
      player.play_card(deck)
    end

    it "should discard the chosen card to the deck" do
      allow(interface).to receive(:choose_card).and_return(card)
      allow(interface).to receive(:choose_suit).and_return(:hearts)
      allow(deck).to receive(:draw).and_return(card)
      allow(deck).to receive(:discard)
      allow(deck).to receive(:last_discarded).and_return(Card.new(:diamonds, :four))
      player = Player.new("Frank", interface)
      player.draw(deck)
      expect(deck).to receive(:discard)
      player.play_card(deck)
    end

    it "shouldn't discard the chosen card if it's not valid" do
      allow(interface).to receive(:choose_card).and_return(Card.new(:diamonds, :four))
      allow(deck).to receive(:draw).and_return(card)
      allow(deck).to receive(:last_discarded).and_return(Card.new(:hearts, :three))
      player = Player.new("Frank", interface)
      player.draw(deck)
      expect{ player.play_card(deck) }.to raise_error
    end

    it "should remove the card from the players hand" do
      allow(interface).to receive(:choose_card).and_return(card)
      allow(interface).to receive(:choose_suit).and_return(:hearts)
      allow(deck).to receive(:draw).and_return(card)
      allow(deck).to receive(:discard)
      allow(deck).to receive(:last_discarded).and_return(Card.new(:diamonds, :four))
      player = Player.new("Frank", interface)
      player.draw(deck)
      player.play_card(deck)
      expect(player.hand_size).to eq(0)
    end

  end



end
