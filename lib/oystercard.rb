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
    maximum_balance_reached(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    insufficient_funds
    touched_in_but_not_out
    @journey.start(entry_station)
  end

  def touch_out(exit_station)
    @journey.finish(exit_station)
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

  def maximum_balance_reached(amount)
    raise "Maximum balance of #{DEFAULT_LIMIT} exceeded" if limit_reached?(amount)
  end

  def insufficient_funds
    raise "Minimum balance not met" if @balance < MINIMUM_BALANCE
  end

  def touched_in_but_not_out
    if @journey.entry_station != nil && @journey.exit_station == nil
      @journey_history << @journey.current_journey
      deduct(@journey.fare)
    end
  end

end
