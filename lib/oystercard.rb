require './lib/journey'

class Oystercard
  attr_accessor :balance, :entry_station, :exit_station, :journey_history

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @journey_history = []
    @journey = nil
  end

  def top_up(amount)
    raise ("Exceeded max balance") if exceeded_balance?(amount)
    @balance += amount
  end

  def touch_in(station) # penalty if: dont touch out
    deduct(@journey.fare) if @journey #journey was not reset to nil because they didn't touch out
    raise("Please top up, not enough money") if balance_too_low?
    @journey = Journey.new(entry_station: station)
  end

  def touch_out(station) # penalty if: dont touch in
    @journey.end_journey(station) if @journey
    @journey = Journey.new(exit_station: station) unless @journey #journey was not initialized because they didn't touch in
    deduct(@journey.fare) # #fare checks if journey is completed (both stations != nil)
    @journey = nil
  end

  private

  def log_journey
    journey_history << [@journey.entry_station, @journey.exit_station]
  end

  def balance_too_low?
    @balance < MIN_BALANCE
  end

  def deduct(fare)
    puts "You have been charged £#{fare}"
    @balance -= fare
    log_journey
  end

  def exceeded_balance?(amount)
    @balance + amount > MAX_BALANCE
  end
  
end