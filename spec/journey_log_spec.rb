require 'journey_log'

describe JourneyLog do

  describe 'when initialized' do
    let(:journey) { double 'journey' }
    subject(:journey_log) { described_class.new(journey) }

    # creates a new instance of journey and stores this to journey class
    it 'creates a new instance of Journey' do
      expect(journey_log.journey_class).to be_an_instance_of Journey
    end
  end  

end