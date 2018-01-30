require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

  context "when initialize is passed argument" do
    subject(:oystercard) { described_class.new(20) }
    it "balance equals argument" do
      expect(oystercard.balance).to eq 20
    end
  end
  context "when initialize not passed argument" do
    it "balance equals default balance" do
      expect(oystercard.balance).to eq Oystercard::DEFAULT_BALANCE
    end
  end

  describe "#top_up" do
    it "tops up the oyster card" do
      amount = 10
      expect{ oystercard.top_up(amount)}.to change{oystercard.balance}.by(amount)
    end

    context "when balance exceeds maximum limit" do
      it "raises 'Maximum balance exceeded' error" do
        error_message = "Maximum balance of #{Oystercard::DEFAULT_LIMIT} exceeded"
        amount = Oystercard::DEFAULT_LIMIT - oystercard.balance + 1
        expect{ oystercard.top_up(amount) }.to raise_error error_message
      end
    end
  end

  describe "#in_journey" do
    it "returns whether or not the card is in journey" do
      expect(oystercard.in_journey?).to eq(true).or eq(false)
    end
  end

  describe "#touch_in" do
    it "raises an error if minimum balance is not met" do
        error_message = "Minimum balance not met"
        expect { oystercard.touch_in }.to raise_error error_message
      end

    it "starts journey if there is enough money on the card" do
      oystercard.top_up(Oystercard::MINIMUM_BALANCE)
      expect{oystercard.touch_in}.to change{oystercard.in_journey?}.from(false).to(true)
    end
  end

  describe "#touch_out" do
    it "ends journey" do
      oystercard.top_up(Oystercard::MINIMUM_BALANCE)
      oystercard.touch_in
      expect{oystercard.touch_out}.to change{oystercard.in_journey?}.from(true).to(false)
    end

    it "raises error if in_journey is false" do
      error_message = "Not yet in journey"
      expect { oystercard.touch_out }.to raise_error error_message
    end

    it "deducts fare from the card balance" do
      oystercard.top_up(Oystercard::MINIMUM_BALANCE)
      oystercard.touch_in
      expect{oystercard.touch_out}.to change{oystercard.balance}.by(-Oystercard::MINIMUM_BALANCE)
    end

  end
end
