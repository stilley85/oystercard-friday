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
      expect{ subject.top_up(top_up_amount)}.to change{subject.balance}.by(top_up_amount)
    end

    context "when balance exceeds maximum limit" do
      it "raises 'Maximum balance exceeded' error" do
        error_message = "Maximum balance of #{Oystercard::DEFAULT_LIMIT} exceeded"
        top_up_amount = Oystercard::DEFAULT_LIMIT - subject.balance + 1
        expect{ subject.top_up(top_up_amount) }.to raise_error error_message
      end
    end
  end

  describe "#deduct" do
    it "deducts fare from the oyster card" do
      fare_amount = 5
      expect{subject.deduct(fare_amount)}.to change{subject.balance}.by(-fare_amount)
    end
  end

  describe "#in_journey" do
    it "returns whether or not the card is in journey" do
      expect(subject.in_journey?).to eq(true).or eq(false)
    end
  end

  describe "#touch_in" do
end
