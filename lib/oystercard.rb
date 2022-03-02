class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journey_history

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @journey_history = {}
  end

  def top_up(amount)
    raise ("Exceeded max balance") if exceeded_balance?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise("You have already touched in") if in_journey?
    raise("Please top up, not enough money") if balance_too_low?
    puts "you have now touched in"
    @entry_station = station
    @start_time = Time.now
  end



  def touch_out(station)
    raise("You have not touched in") unless in_journey?
    @exit_station = station
    deduct
    log_journey
  end

  def in_journey?
    @entry_station != nil
  end

  private
  def log_journey
    journey_history[@start_time] = [@entry_station, @exit_station]
    reset_journey
  end

  def reset_journey
    @entry_station = nil
    @exit_station = nil
    @start_time = nil
  end

  def deduct
    fare = 1
    @balance -= fare
  end
  
  def balance_too_low?
    @balance < MIN_BALANCE
  end

  def exceeded_balance?(amount)
    @balance + amount > MAX_BALANCE
  end
  
end