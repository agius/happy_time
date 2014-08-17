module ActiveSupport
  class TimeZone
    def self.names
      MAPPING.keys
    end
  end
end