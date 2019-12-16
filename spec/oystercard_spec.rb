require './lib/oystercard'

describe Oystercard do 
  describe 'initialization' do 
    it 'expects zero opening balance' do
    expect(subject.balance).to eq 0
    end 
  end 

  describe 'top up' do 
    it {is_expected.to respond_to(:top_up).with(1).argument }
   
    it 'balance to update to 10 with top_up(10)' do 
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end 

    it 'has a max limit of 90'do 
      max_balance = Oystercard::LIMIT
      subject.top_up(max_balance)
      expect{subject.top_up(3)}.to raise_error "ERROR - card already holds max funds (Max = #{max_balance}"
    end 
  end 

  describe 'deduct' do 
    it 'deducts 10 from balance' do 
      subject.top_up(10)
      subject.deduct(10)
      expect(subject.balance).to eq 0
  end 
  end 

end 
