# require 'journey_log'
#
# describe JourneyLog do
#
#   describe 'when initialized' do
#     let(:journey) { double 'journey' }
#     # subject(:journey_log) { described_class.new(journey) }
#     let(:entry_station) {double('entry station')}
#     let(:exit_station) {double('exit_station')}
#
#     # creates a new instance of journey and stores this to journey class
#     it 'creates a new instance of Journey' do
#       expect(subject.journey_class).to be_an_instance_of Journey
#     end
#   end
#
#   describe "#start" do
#     it "starts a new journey with an entry station" do
#       subject.journey_class
#       subject.start(entry_station)
#       expect(subject.journey_class.entry_station).to eq entry_station
#     end
#   end
#
# end
