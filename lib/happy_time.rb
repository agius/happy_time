require 'time'
require 'active_support'
require 'active_support/time'

require "happy_time/version"
require "happy_time/time_formatter"
require "happy_time/validators/time_is_validator"
require "happy_time/active_support/active_support_ext"
require "happy_time/helpers/view_helpers"

if defined?(RSpec)
  require 'happy_time/matchers/time_matchers'
end

module HappyTime
  module Rails
    class Engine < ::Rails::Engine
      ActionView::Base.send :include, HappyTime::ViewHelpers
    end
  end
end
