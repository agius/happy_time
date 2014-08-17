require 'spec_helper'

class TestEventBeforeNow < TestModel
  validates :event_at, time_is: { before_now: true }
end

class TestEventAfterNow < TestModel
  validates :event_at, time_is: { after_now: true }
end

class TestEventNowOrEarlier < TestModel
  validates :event_at, time_is: { now_or_earlier: true }
end

class TestEventNowOrLater < TestModel
  validates :event_at, time_is: { now_or_later: true }
end

class TestEventBefore < TestModel
  validates :event_at, time_is: { before: :the_time }
end

class TestEventAfter < TestModel
  validates :event_at, time_is: { after: :the_time }
end

class TestEventEarlier < TestModel
  validates :event_at, time_is: { at_or_before: :the_time }
end

class TestEventLater < TestModel
  validates :event_at, time_is: { at_or_after: :the_time }
end

describe TimeIsValidator do

  describe "validations" do

    it 'validates time before now' do
      expect(TestEventBeforeNow.new(event_at: Time.now + 3)).to_not be_valid
      expect(TestEventBeforeNow.new(event_at: Time.now    )).to_not be_valid
      expect(TestEventBeforeNow.new(event_at: Time.now - 3)).to be_valid
    end
    
    it 'validates time after now' do
      expect(TestEventAfterNow.new(event_at: Time.now - 3)).to_not be_valid
      expect(TestEventAfterNow.new(event_at: Time.now    )).to_not be_valid
      expect(TestEventAfterNow.new(event_at: Time.now + 3)).to be_valid
    end

    it 'validates time now or earlier' do
      expect(TestEventNowOrEarlier.new(event_at: Time.now + 3)).to_not be_valid
      expect(TestEventNowOrEarlier.new(event_at: Time.now    )).to be_valid
      expect(TestEventNowOrEarlier.new(event_at: Time.now - 3)).to be_valid
    end

    it 'validates time now or later' do
      expect(TestEventNowOrLater.new(event_at: Time.now + 3)).to be_valid
      expect(TestEventNowOrLater.new(event_at: Time.now    )).to be_valid
      expect(TestEventNowOrLater.new(event_at: Time.now - 3)).to_not be_valid
    end

    it 'validates time is before the_time' do
      expect(TestEventBefore.new(event_at: Time.now + 3, the_time: Time.now + 5)).to be_valid
      expect(TestEventBefore.new(event_at: Time.now + 3, the_time: Time.now + 3)).to_not be_valid
      expect(TestEventBefore.new(event_at: Time.now + 3, the_time: Time.now - 3)).to_not be_valid
    end

    it 'validates time is after the_time' do
      expect(TestEventAfter.new(event_at: Time.now + 3, the_time: Time.now + 5)).to_not be_valid
      expect(TestEventAfter.new(event_at: Time.now + 3, the_time: Time.now + 3)).to_not be_valid
      expect(TestEventAfter.new(event_at: Time.now + 3, the_time: Time.now - 3)).to be_valid
    end

    it 'validates time is at the_time or earlier' do
      expect(TestEventEarlier.new(event_at: Time.now + 3, the_time: Time.now + 5)).to be_valid
      expect(TestEventEarlier.new(event_at: Time.now + 3, the_time: Time.now + 3)).to be_valid
      expect(TestEventEarlier.new(event_at: Time.now + 3, the_time: Time.now - 3)).to_not be_valid
    end

    it 'validates time is at the_time or later' do
      expect(TestEventLater.new(event_at: Time.now + 3, the_time: Time.now + 5)).to_not be_valid
      expect(TestEventLater.new(event_at: Time.now + 3, the_time: Time.now + 3)).to be_valid
      expect(TestEventLater.new(event_at: Time.now + 3, the_time: Time.now - 3)).to be_valid
    end

    it 'raises error on invalid checks' do
      expect{
        class InvalidTestEvent < TestModel
          validates :event_at, time_is: { not_valid: true }
        end  
      }.to raise_error(ArgumentError)
    end

  end

end