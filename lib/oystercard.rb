class Oystercard

  DEFAULT_BALANCE = 5
  attr_reader :balance 

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

end
