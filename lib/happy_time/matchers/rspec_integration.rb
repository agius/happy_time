if defined?(RSpec) && RSpec.respond_to?(:configure)

  require 'happy_time/matchers/time_matcher'
  require 'happy_time/matchers/be_time'
  require 'happy_time/matchers/be_before'
  require 'happy_time/matchers/be_after'
  require 'happy_time/matchers/be_at_or_before'
  require 'happy_time/matchers/be_at_or_after'

  RSpec.configure do |config|
    config.include HappyTime::Matchers
  end
end