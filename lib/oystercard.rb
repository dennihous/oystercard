class Oystercard
  attr_reader :balance, :entry_station

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @entry_station
  end

  def top_up(amount)
    raise ("Exceeded max balance") if exceeded_balance?(amount)
    @balance += amount
  end

  def touch_in(entry)
    raise("You have already touched in") if in_journey?
    raise("Please top up, not enough money") if balance_too_low?
    puts "you have now touched in"
    @entry_station = entry
  end

  def touch_out
    raise("You have not touched in") unless in_journey?
    deduct && @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

  private
  def deduct
    fare = 1
    @balance -= fare
  end
  
  def balance_too_low?
    @balance < MIN_BALANCE
  end

  def exceeded_balance?(amount)
    total_amount = balance + amount
    total_amount > MAX_BALANCE
  end
  
end