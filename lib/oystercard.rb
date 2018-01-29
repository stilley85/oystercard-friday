class Oystercard

  DEFAULT_BALANCE = 5
  DEFAULT_LIMIT = 90
  attr_reader :balance

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(amount)
    raise "Maximum balance of #{DEFAULT_LIMIT} exceeded" if limit_reached?(amount)
    @balance += amount
  end

  private

  def limit_reached?(amount)
    (@balance + amount) > DEFAULT_LIMIT
  end

end
