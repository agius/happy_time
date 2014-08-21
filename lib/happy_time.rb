require 'time'
require 'active_support'
require 'active_support/time'

require "happy_time/version"
require "happy_time/configuration"
require "happy_time/concerns/configurable"
require "happy_time/time_formatter"
require "happy_time/time_formatter/formatter"
require "happy_time/time_formatter/momentizer"
require "happy_time/validators/time_is_validator"
require "happy_time/helpers/view_helpers"
require "happy_time/rails"
require "happy_time/core_ext/time"
require "happy_time/core_ext/date"
require 'happy_time/matchers/rspec_integration'

module HappyTime

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= HappyTime::Configuration.new
    yield(configuration)
  end

  def self.configuration
    @configuration ||= HappyTime::Configuration.new
  end

  def self.reset!
    @configuration = Configuration.new
    @names = nil
    @abbreviations = nil
    @zones = nil
    HappyTime::TimeFormatter::Momentizer.reset!
  end

  def self.format(*args)
    HappyTime::TimeFormatter.format(*args)
  end

  def self.zone_names
    return @names if @names.present?
    @names = ActiveSupport::TimeZone::MAPPING.keys
  end

  def self.abbreviations
    return @abbreviations if @abbreviations.present?
    @abbreviations = zones.collect{|zone| zone.now.zone }
  end

  def self.zones
    return @zones if @zones.present?
    @zones = (ActiveSupport::TimeZone.us_zones + ActiveSupport::TimeZone.all.reverse).uniq
  end

end
