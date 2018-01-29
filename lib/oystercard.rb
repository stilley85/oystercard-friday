class Oystercard

  DEFAULT_BALANCE = 5
  DEFAULT_LIMIT = 90
  attr_reader :balance

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    raise "Maximum balance of #{DEFAULT_LIMIT} exceeded" if limit_reached?(amount)
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end 

  private

  def limit_reached?(amount)
    (@balance + amount) > DEFAULT_LIMIT
  end
end
