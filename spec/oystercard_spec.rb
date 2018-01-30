require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

  context "when new oystercard is initialized with argument" do
    subject(:oystercard) { described_class.new(20) }
    it "has balance given" do
      expect(oystercard.balance).to eq 20
    end
  end

  context "when new oystercard is initialized without argument" do
    it "has default balance" do
    expect(oystercard.balance).to eq Oystercard::DEFAULT_BALANCE
    end
  end

  context "when oystercard has minimum balance or more" do
    describe "#touch_in" do
      it "starts journey" do
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

      it "deducts fare from the card balance" do
        oystercard.top_up(Oystercard::MINIMUM_BALANCE)
        oystercard.touch_in
        expect{oystercard.touch_out}.to change{oystercard.balance}.by(-Oystercard::MINIMUM_BALANCE)
      end
    end
  end

  context "when oystercard does not have minimum balance" do
    describe "#touch_in" do
      it "raises an error" do
        error_message = "Minimum balance not met"
        expect { oystercard.touch_in }.to raise_error error_message
      end
    end
  end

  describe "#top_up" do
    it "increases oystercard balance" do
      amount = 10
      expect{ oystercard.top_up(amount)}.to change{oystercard.balance}.by(amount)
    end
    it "raises error if maximum balance exceeded" do
      error_message = "Maximum balance of #{Oystercard::DEFAULT_LIMIT} exceeded"
      amount = Oystercard::DEFAULT_LIMIT - oystercard.balance + 1
      expect{ oystercard.top_up(amount) }.to raise_error error_message
    end
  end

  describe "#in_journey" do
    it "returns whether or not the card is in journey" do
      expect(oystercard.in_journey?).to eq(true).or eq(false)
    end
  end

    describe "#touch_out" do
    it "raises error if card hasn't been touched in" do
      error_message = "Not yet in journey"
      expect { oystercard.touch_out }.to raise_error error_message
    end
  end
end
