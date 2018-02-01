require 'journey'

describe Journey do

  subject(:journey) {described_class.new}
  let(:entry_station) {double('an entry station')}

  context 'when initialized' do
    it "registers an entry station" do
      expect(journey.entry_station).to eq nil 
    end

    it 'registers an exit station' do
      expect(journey.exit_station).to eq nil
    end  

    it 'registers a journey status' do
      expect(journey.in_journey?). to eq false 
    end
  end




   # it "returns whether or not the card is in journey" do
    #   expect(oystercard.in_journey?).to eq(true).or eq(false)
    # end


end