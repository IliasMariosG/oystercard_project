
class Oystercard

attr_reader :balance, :limit, :travelling, :min_balance, :entry_station, :journey

LIMIT = 90
MIN_BALANCE = 1


  def initialize(limit=LIMIT, min_balance = MIN_BALANCE)
    @balance = 0
    @limit = limit
    @min_balance = min_balance
    @entry_station = nil
    @journey = []
  end 

  def top_up(amount)
    fail "ERROR - card already holds max funds (Max = #{@limit}" if (amount + @balance) > @limit
    @balance += amount
  end

  def touch_in(entry_station)
    fail "Insufficient Funds" if @balance < @min_balance
    @entry_station = entry_station
  end 

  def touch_out(exit_station)
    deduct(@min_balance)
    @entry_station = nil

  end 

  def in_journey?
    # return true unless @entry_station == nil 
    !!entry_station
  end 

  def store_journey(start, finish)
    journey_hash = {
      "start" => start, 
      "finish" => finish
    }
  #   @journey << journey_hash
  end 

  private

  def deduct(amount)
    @balance -= amount
  end 

end 