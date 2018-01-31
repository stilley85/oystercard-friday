class Oystercard
  # test
  Hello
  DEFAULT_BALANCE = 0
  MINIMUM_BALANCE = 1
  DEFAULT_LIMIT = 90
  attr_reader :balance, :entry_station, :exit_station, :journey_history, :current_journey

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @entry_station = nil
    @exit_station = nil
    @journey_history = []
    @current_journey = {@entry_station => @exit_station}
  end

  def top_up(amount)
    raise "Maximum balance of #{DEFAULT_LIMIT} exceeded" if limit_reached?(amount)
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(station)
    raise "Minimum balance not met" if @balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def touch_out(station)
    raise "Not yet in journey" unless in_journey?
    deduct(MINIMUM_BALANCE)
    @entry_station = nil
    @exit_station = station
    # create test for save_journey
  end

  private

  def limit_reached?(amount)
    (@balance + amount) > DEFAULT_LIMIT
  end

  def deduct(fare)
    @balance -= fare
  end

  def save_journey
    @journey_history.push(@current_journey)
  end
end
