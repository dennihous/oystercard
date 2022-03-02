require 'oystercard'

describe Oystercard do

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  describe "testing the :top_up method" do
    it 'has a balance of 0 on the card' do
      expect(subject.balance).to eq(0)
    end
    it 'should respond to the top_up method' do
      expect(subject).to respond_to(:top_up)
    end

    it 'should return 5 when passed an argument of 5' do
      expect(subject.top_up(5)).to eq(5)
    end

    it 'should top up the card balance by 5' do
      subject.top_up(5)
      expect(subject.balance).to eq(5)
    end

    it "should raise an error when top_up result in balance above #{Oystercard::MAX_BALANCE}" do
      expect do
        subject.top_up(Oystercard::MAX_BALANCE + 5)
      end.to raise_error("Exceeded max balance")
    end

    it "should not raise and error when top_up results in less than #{Oystercard::MAX_BALANCE} balance" do
      expect do
        subject.top_up(Oystercard::MAX_BALANCE)
      end.not_to raise_error
    end

  end

  describe "testing :touch_in method" do

    it "should respond to :touch_in" do
      expect(subject).to respond_to(:touch_in)
    end

    it "should raise an error if min balance hasn't been met" do
      expect{ subject.touch_in(entry_station) }.to raise_error("Please top up, not enough money")
    end

    it "should not raise an error if balance is above minimum balance" do
      subject.top_up(1)
      expect{ subject.touch_in(entry_station) }.not_to raise_error
    end

    it "should not be able to :touch_in if in_journey?" do
      subject.top_up(5)
      subject.touch_in(entry_station)
      expect{ subject.touch_in(entry_station) }.to raise_error("You have already touched in")
    end

    it "should remember the entry station" do
      subject.top_up(5)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end

  end

  describe "testing :touch_out method" do
    before do
      subject.top_up(5)
    end

    it "should respond to :touch_out" do
      expect(subject).to respond_to(:touch_out)
    end

    it "should deduct the fare of £1 from the balance when calling :touch_out" do
      subject.touch_in(entry_station)
      expect{ subject.touch_out(exit_station) }.to change{subject.balance}.by(-1)
    end

    it "should raise an error if :touch_out is called before :touch_in" do
      expect{ subject.touch_out(exit_station) }.to raise_error("You have not touched in")
    end

    it "should make entry_station return nil after touch_out" do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.entry_station).to be_nil
    end

    it "logs the completed journey" do
      allow(Time).to receive(:now).and_return(:start_time)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journey_history).to eq({ start_time: [entry_station, exit_station]})
    end

  end

  describe "testing the :in_journey? method" do
    it "should respond to :in_journey?" do
      expect(subject).to respond_to(:in_journey?)
    end

    it "should return a boolean value" do
      expect(subject.in_journey?).to eq(true).or eq(false)
    end

    it "should not be in a journey when a new card is created" do
      expect(subject).not_to be_in_journey
    end

    it "should be in a journey when a card is touched in" do
      subject.top_up(1)
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end

    it "should revert to not being in a journey once touched out" do
      subject.top_up(1)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end

  end
  describe "#initalize" do
    it "should return an empty array before touching in" do
      expect(subject.journey_history).to be_empty
    end
  end
  
end