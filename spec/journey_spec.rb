require 'journey'

describe Journey do
  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }

  describe "#end_journey" do
  
    it "should return nil it not touched out" do
      subject.end_journey()
      expect(subject.exit_station).to be_nil
    end

    it "should remember the station if touched out" do
      subject.end_journey(exit_station)
      expect(subject.exit_station).to be exit_station
    end
  end

  describe "#journey_finished?" do

    context "when no station is passed when initialising" do

      it "should return false if entry_station is nil" do
        subject.end_journey(exit_station)
        expect(subject.journey_finished?).to eq false    
      end
      it "should return false if both entry_station and exit_station are nil" do
        expect(subject.journey_finished?).to eq false    
      end
    end

    context "when entry_station is passed when initialising" do
      subject { described_class.new(entry_station: entry_station) }
      it "should return false if exit_station is nil" do
        expect(subject.journey_finished?).to eq false    
      end
      it "should return true if entry_station and exit_station are not nil" do
        subject.end_journey(exit_station)
        expect(subject.journey_finished?).to eq true
      end
      it "should return false if exit_station is nil" do
        expect(subject.journey_finished?).to eq false    
      end
      
    end
    
  end

  describe "#fare" do
    subject { described_class.new(entry_station: entry_station) }
    it "should return MINIMUM_FARE when #journey_finished? is true" do
      subject.end_journey(exit_station)
      expect(subject.fare).to eq(Journey::MINIMUM_FARE)

    end
    it "should return PENALTY_FARE when #journey_finished? is false" do
      expect(subject.fare).to eq(Journey::PENALTY_FARE)
    end

  end
  
end