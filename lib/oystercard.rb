
class Oystercard

attr_reader :balance, :limit

LIMIT = 90

  def initialize(limit=LIMIT)
    @balance = 0
    @limit = limit
  end 

  def top_up(amount)
    fail "ERROR - card already holds max funds (Max = #{@limit}" if (amount + @balance) > @limit
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end 

end 