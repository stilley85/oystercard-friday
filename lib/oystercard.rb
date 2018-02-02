require_relative "station"
require_relative "journey"

class Oystercard

  DEFAULT_BALANCE = 0
  MINIMUM_BALANCE = 1
  DEFAULT_LIMIT = 90
  attr_reader :balance, :journey_history, :journey

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journey_history = []
    @journey = Journey.new
  end

  def top_up(amount)
    raise "Maximum balance of #{DEFAULT_LIMIT} exceeded" if limit_reached?(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Minimum balance not met" if @balance < MINIMUM_BALANCE
    if @journey.entry_station != nil && @journey.exit_station == nil
      @journey_history << @journey
      deduct(@journey.fare)
    end
    @journey = Journey.new
    @journey.start(entry_station)
    # return value of line 23 is entry_station
    # @entry_station = entry_station
  end

  def touch_out(exit_station)
    raise "Not yet in journey" if @journey == nil
    @journey.finish(exit_station)
    # @exit_station = exit_station
    save_journey
    deduct(@journey.fare)
  end

  private

  def limit_reached?(amount)
    (@balance + amount) > DEFAULT_LIMIT
  end

  def deduct(fare)
    @balance -= fare
  end

  def save_journey
    @journey_history << @journey.current_journey
  end

end
