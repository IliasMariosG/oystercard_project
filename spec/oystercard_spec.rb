require './lib/oystercard'
# require './lib/oyster_travel'

describe Oystercard do 
  describe '#initialization' do 
    it 'expects zero opening balance' do
    expect(subject.balance).to eq 0
    end 
    it 'expects an empty array as default'do 
      expect(subject.journey_history).to eq []
    end 
  end 

  describe '#top up' do 
    it {is_expected.to respond_to(:top_up).with(1).argument }
   
    it 'updates balance to min fare when topped-up with an amount of money' do 
      subject.top_up(Oystercard::MIN_FARE)
      expect(subject.balance).to eq Oystercard::MIN_FARE
    end 

    it 'has a max limit of 90'do 
      expect{subject.top_up(Oystercard::MAX_LIMIT + 1)}.to raise_error "ERROR - card already holds max funds (Max = #{Oystercard::MAX_LIMIT}"
    end 
  end 

let(:station) {double :station}
  describe '#touch_in' do 
    it 'raises error if insufficient funds on card' do 
      expect{subject.touch_in(station)}.to raise_error "Insufficient Funds" 
    end 
    it 'stores entry_station' do 
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end

    it 'stores entry station inside a hash' do
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(station)
      expect(subject.journey[:entry_station]).to eq station
    end

  end 

  describe '#touch_out' do 
    it 'accepts 1 argument' do 
      expect(subject).to respond_to(:touch_out).with(1).argument
    end 
    it 'deducts min_balance from @balance' do 
      subject.top_up(Oystercard::MIN_FARE)
      expect{subject.touch_out(:exit_station)}.to change{subject.balance}.by(-Oystercard::MIN_FARE)
    end 
      it 'forgets station on touch_out' do 
        subject.top_up(Oystercard::MIN_FARE)
        subject.touch_in(station)
        subject.touch_out(:exit_station)
        expect(subject.entry_station).to eq nil
      end  

      it 'stores exit_station' do 
        subject.top_up(Oystercard::MIN_FARE)
        subject.touch_in(station)
        subject.touch_out(station)
        expect(subject.exit_station).to eq station
      end

      it 'stores exit station inside a hash' do
        subject.top_up(Oystercard::MIN_FARE)
        subject.touch_in(station)
        subject.touch_out(station)
        expect(subject.journey[:exit_station]).to eq station
      end 
  end 

  describe '#in_journey?' do
    it 'should be false when @entry_station eq nil' do
      expect(subject.in_journey?).to be_falsey
      end 
    it 'should be true when entry_station eq a station' do
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(station)
      expect(subject.in_journey?).to be_truthy
    end 
  end 

  # let(:start) {double :start}
  # let(:finish) {double :finish}
  # describe '#store_journey' do 
  #   it 'should store entry and exit stations in hash' do 
  #     expect(subject.store_journey(start, finish)).to be_a(Hash) 
  #   end 
  #   # @journey_hash.should include(
  #   #   "start" => Oystercard.new.entry_station
  #   # )
  # end 
end 

