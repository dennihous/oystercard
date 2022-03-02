require 'station'

describe Station do
  describe "#initialize method" do
    let(:station){ Station.new("Teddington", 6) }
    it "should record the name of a station" do
      expect(station.name).to eq("Teddington")
    end

    it "should record the zone of the station" do
      expect(station.zone).to eq(6)
    end
  end

end