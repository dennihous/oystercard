require 'oystercard'

describe Oystercard do
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

  it 'should decrease the balance by 5 when deduct(5) is implemented' do
    subject.top_up(10)
    subject.deduct(5)
    expect(subject.balance).to eq(5)
  end
end