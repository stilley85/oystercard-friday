require 'journey'

describe Journey do

  subject(:journey) {described_class.new}
  let(:entry_station_same_zone) {double('entry station', zone: 1)}
  let(:exit_station_same_zone) {double('exit_station', zone: 1)}
  let(:entry_station) {double('entry station', zone: 1)}
  let(:exit_station) {double('exit_station', zone: 3)}

  context 'when initialized' do
    it "registers an entry station" do
      expect(journey.entry_station).to eq nil
    end

    it 'registers an exit station' do
      expect(journey.exit_station).to eq nil
    end

    it 'registers a journey status' do
      expect(journey.complete?). to eq false
    end
  end

  describe '#start' do
    it 'sets an entry station' do
      expect(journey.start(entry_station)).to eq entry_station
    end
  end

  describe '#finish' do
    it 'sets an exit station' do
      journey.start(entry_station)
      journey.finish(exit_station)
      expect(journey.exit_station).to eq exit_station
    end
  end

  describe '#complete?' do
    context 'when oystercard touches in and out' do
      it 'changes status to true' do
        journey.start(entry_station)
        journey.finish(exit_station)
        expect(journey.complete?).to eq true
      end
    end

    describe '#fare' do

    it 'charges minimum fare if a journey has been completed within same zone' do
      journey.start(entry_station_same_zone)
      journey.finish(exit_station_same_zone)
      expect(journey.fare).to eq Journey::MINIMUM_FARE
      end

      it 'charges calculated if a journey has been completed within different zone' do

        journey.start(entry_station)
        journey.finish(exit_station)
        expect(journey.fare).to eq 3
        end

    # it 'charges a penalty fare if journey incomplete ' do
    #   journey.start(entry_station)
    #   journey.finish(exit_station)
    #   journey.finish(exit_station)
    #   expect(journey.fare).to eq Journey::PENALTY_FARE
    #   end
    end




  end
end
