require 'spec_helper'

describe HappyTime::Matchers do

  specify 'be_at' do
    expect(Time.now).to be_time(Time.now)
    expect(Time.now).to_not be_time(Time.now - 3)
  end

  specify 'be_before' do
    expect(Time.now).to be_before(Time.now + 3)
    expect(Time.now).to_not be_before(Time.now)
    expect(Time.now).to_not be_before(Time.now - 3)
  end

  specify 'be_after' do
    expect(Time.now).to_not be_after(Time.now + 3)
    expect(Time.now).to_not be_after(Time.now)
    expect(Time.now).to be_after(Time.now - 3)
  end

  specify 'be_at_or_before' do
    expect(Time.now).to_not be_at_or_after(Time.now + 3)
    expect(Time.now).to be_at_or_after(Time.now)
    expect(Time.now).to be_at_or_after(Time.now - 3)
  end

  specify 'be_at_or_before' do
    expect(Time.now).to be_at_or_before(Time.now + 3)
    expect(Time.now).to be_at_or_before(Time.now)
    expect(Time.now).to_not be_at_or_before(Time.now - 3)
  end

end