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
      top_up_amount = 10
      expect{ oystercard.top_up(top_up_amount)}.to change{oystercard.balance}.by(top_up_amount)
    end

    context "when balance exceeds maximum limit" do
      it "raises 'Maximum balance exceeded' error" do
        error_message = "Maximum balance of #{Oystercard::DEFAULT_LIMIT} exceeded"
        top_up_amount = Oystercard::DEFAULT_LIMIT - oystercard.balance + 1
        expect{ oystercard.top_up(top_up_amount) }.to raise_error error_message
      end
    end
  end

  describe "#deduct" do
    it "deducts fare from the oyster card" do
      fare_amount = 5
      expect{oystercard.deduct(fare_amount)}.to change{oystercard.balance}.by(-fare_amount)
    end
  end

  describe "#in_journey" do
    it "returns whether or not the card is in journey" do
      expect(oystercard.in_journey?).to eq(true).or eq(false)
    end
  end

  describe "#touch_in" do
    it "starts journey" do
      expect{oystercard.touch_in}.to change{oystercard.in_journey?}.from(false).to(true)
    end
  end

  describe "#touch_out" do
    it "ends journey" do
      oystercard.touch_in
      expect{oystercard.touch_out}.to change{oystercard.in_journey?}.from(true).to(false)
    end
  end
end
