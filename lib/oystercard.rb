class Oystercard

  DEFAULT_BALANCE = 0
  MINIMUM_BALANCE = 1
  DEFAULT_LIMIT = 90
  attr_reader :balance, :entry_station

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @entry_station = nil
  end

  def top_up(amount)
    raise "Maximum balance of #{DEFAULT_LIMIT} exceeded" if limit_reached?(amount)
    @balance += amount
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(station)
    raise "Minimum balance not met" if @balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def touch_out
    raise "Not yet in journey" unless in_journey?
    deduct(MINIMUM_BALANCE)
    @entry_station = nil
  end

  private

  def limit_reached?(amount)
    (@balance + amount) > DEFAULT_LIMIT
  end

  def deduct(fare)
    @balance -= fare
  end
end
