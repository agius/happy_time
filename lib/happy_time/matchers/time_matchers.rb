# compare times using integer differences
# gets rid of timezone issues and nanosecond comparison
RSpec::Matchers.define :be_time do |expected|
  match do |actual|
    expected == actual || ((expected - actual) < 1 && (expected - actual) > -1)
  end

  failure_message do |actual|
    format = '%b %-d, %Y %H:%M:%S %N %z'
    "expected #{actual.strftime(format)} would be #{expected.strftime(format)}"
  end
end

RSpec::Matchers.define :be_before do |expected|
  match do |actual|
    (expected - actual) < 0
  end

  failure_message do |actual|
    format = '%b %-d, %Y %H:%M:%S %N %z'
    "expected #{actual.strftime(format)} would be before #{expected.strftime(format)}"
  end
end

RSpec::Matchers.define :be_after do |expected|
  match do |actual|
    (actual - expected) > 0
  end

  failure_message do |actual|
    format = '%b %-d, %Y %H:%M:%S %N %z'
    "expected #{actual.strftime(format)} would be after #{expected.strftime(format)}"
  end
end

RSpec::Matchers.define :be_at_or_before do |expected|
  match do |actual|
    (expected - actual) < -1
  end

  failure_message do |actual|
    format = '%b %-d, %Y %H:%M:%S %N %z'
    "expected #{actual.strftime(format)} would be at or before #{expected.strftime(format)}"
  end
end

RSpec::Matchers.define :be_at_or_after do |expected|
  match do |actual|
    (actual - expected) > -1
  end

  failure_message do |actual|
    format = '%b %-d, %Y %H:%M:%S %N %z'
    "expected #{actual.strftime(format)} would be after #{expected.strftime(format)}"
  end
end