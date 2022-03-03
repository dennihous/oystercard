class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station

  def initialize(entry_station: nil, exit_station: nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def end_journey(exit_station=nil)
    @exit_station = exit_station
  end

  def journey_finished?
    @entry_station != nil && @exit_station != nil
  end

  def fare
    journey_finished? ? MINIMUM_FARE : PENALTY_FARE
  end
  
end