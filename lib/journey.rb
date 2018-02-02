class Journey

  attr_reader :entry_station, :exit_station, :in_journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @entry_station = nil
    @exit_station = nil
    @complete = false
  end

  def start(entry_station)
    @entry_station = entry_station
  end

  def finish(exit_station)
    @exit_station = exit_station
    change_complete_status
    # REGARDLESS OF WHWETHER WE'VE TOUCHED IN, WE CHANGE THE
    # STATUS TO COMPLETE
  end

  def complete?
    @complete
  end

  def current_journey
    {:entry_station => @entry_station, :exit_station => @exit_station}
  end

  def fare
    complete? ? MINIMUM_FARE : PENALTY_FARE
  end

private

  def change_complete_status
    if !!entry_station && !!exit_station
      @complete = true
    else
      @complete = false
    end
  end


end
