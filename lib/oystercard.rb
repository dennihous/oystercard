class Oystercard
  attr_reader :balance

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @being_used = false
  end

  def top_up(amount)
    raise ("Exceeded max balance") if exceeded_balance?(amount)
    @balance += amount
  end

  def touch_in
    raise("You have already touched in") if in_journey?
    raise("Please top up, not enough money") if balance_too_low?
    puts "you have now touched in"
    @being_used = true
  end

  def touch_out
    raise("You have not touched in") unless in_journey?
    deduct && @being_used = false
  end

  def in_journey?
    @being_used
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