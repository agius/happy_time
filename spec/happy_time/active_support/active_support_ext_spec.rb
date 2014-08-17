require 'spec_helper'

describe ActiveSupport::TimeZone do

  it 'returns a list of names for time zones' do
    expect(ActiveSupport::TimeZone.names).to be_a(Array)
  end

end