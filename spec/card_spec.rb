require 'card'

describe Card do
  let(:card3S) { Card.new(:spades, :three) }
  let(:card3C) { Card.new(:clubs, :three) }
  let(:cardQS) { Card.new(:spades, :queen) }
  let(:cardKD) { Card.new(:diamonds, :king) }
  let(:cardeight) { Card.new(:hearts, :eight) }
  let(:cardace) { Card.new(:spades, :ace) }
  let(:suitchange) { Card.new(:clubs, :suit_changer)}





  describe "#same_suit?(other_card)" do

    it "returns true with another card of the same suit" do
      expect(card3S.same_suit?(cardQS)).to eq(true)
    end

    it "returns false with another card of the same suit" do
      expect(card3S.same_suit?(card3C)).to eq(false)
    end

  end

  describe "#same_value?(other_card)" do

    it "returns true with another card of the same value" do
      expect(card3S.same_value?(card3C)).to eq(true)
    end

    it "returns true with another card of the same value" do
      expect(card3S.same_value?(cardQS)).to eq(false)
    end

  end

  describe "#crazy?(other_card)" do

    it "returns true for eights" do
      expect(cardeight).to be_crazy
    end

    it "returns false for other cards" do
      expect(card3S).to_not be_crazy
    end

  end

  describe "#valid_match?(other_card)" do

    it "returns true for a valid placement" do
      expect(card3S.valid_match?(cardQS)).to eq(true)
    end

    it "returns true if only the value matches" do
      expect(card3S.valid_match?(card3C)).to eq(true)
    end

    it "returns true for an ace no matter what" do
      expect(cardace.valid_match?(card3C)).to eq(true)
    end

    it "returns true for a suit change" do
      expect(suitchange.valid_match?(cardKD)). to eq(true)
    end

    it "returns false if none of the above are true" do
      expect(cardKD.valid_match?(card3C)).to eq(false)
    end

  end

  describe "#set_suit(suit)" do

    # it "changes the suit of an crazy 8" do
    #   cardeight.set_suit(:diamonds)
    #   expect(cardeight.suit).to eq(:diamonds)
    # end

    it "throws an error if you try to change the suit of a non-crazy card" do
      # expect{card3C.set_suit}.to raise_error
    end

  end

end
