
class Oystercard

attr_reader :balance, :entry_station, :exit_station, :journey_history, :journey

MAX_LIMIT = 90
MIN_FARE = 1


  def initialize 
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journey_history = []
    @journey = { entry_station: nil, exit_station: nil}
  end 

  def top_up(amount)
    fail "ERROR - card already holds max funds (Max = #{MAX_LIMIT}" if (amount + @balance) > MAX_LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient Funds" if @balance < MIN_FARE
    @entry_station = station
    # @journey_history << @entry_station
    @journey[:entry_station] = @entry_station
  end 

  def touch_out(station)
    @exit_station = station
    # @journey_history << @exit_station
    # exit station is added as a key to the journey hash
    @journey[:exit_station] = @exit_station
    deduct(MIN_FARE)
    # After touch out, entry station turn nil again
    @entry_station = nil

  end 

  def in_journey?
    # return true unless @entry_station == nil 
    !!entry_station
  end 

  # def store_journey(start, finish)
  #   journey_hash = {
  #     "start" => start, 
  #     "finish" => finish
  #   }
  # #   @journey << journey_hash
  # end 

  private

  def deduct(amount)
    @balance -= amount
  end 

end 