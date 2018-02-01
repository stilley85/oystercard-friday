require_relative "station"

class Oystercard
  DEFAULT_BALANCE = 0
  MINIMUM_BALANCE = 1
  DEFAULT_LIMIT = 90
  attr_reader :balance, :entry_station, :exit_station, :journey_history

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journey_history = []
  end

  def top_up(amount)
    raise "Maximum balance of #{DEFAULT_LIMIT} exceeded" if limit_reached?(amount)
    @balance += amount
  end

  # def in_journey?
  #   !!@entry_station
  # end

  def touch_in(station)
    raise "Minimum balance not met" if @balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def touch_out(station)
    raise "Not yet in journey" unless in_journey?
    deduct(MINIMUM_BALANCE)
    @exit_station = station
    save_journey
  end

  private

  def limit_reached?(amount)
    (@balance + amount) > DEFAULT_LIMIT
  end

  def deduct(fare)
    @balance -= fare
  end

  def save_journey
    @journey_history << {:entry_station => @entry_station, :exit_station => @exit_station}
  end
end
