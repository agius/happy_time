require 'time'
require 'active_support'
require 'active_support/time'

require "happy_time/version"
require "happy_time/time_is_validator"
require "happy_time/active_support_ext"

module HappyTime
  module Rails
    class Engine < ::Rails::Engine
    end
  end
end
