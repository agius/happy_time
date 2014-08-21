module HappyTime
  module TimeFormatter
    class Momentizer
      include HappyTime::Concerns::Configurable

      @@moments = {}

      def self.reset!
        @@moments = {}
      end

      def self.to_moment(format)
        return @@moments[format] if @@moments[format].present?
        output = configuration.moment_maps.inject(format.dup) do |moment, pattern|
          regex, sub = pattern
          moment.gsub(regex, sub)
        end
        @@moments[format.dup] = output
      end
    end
  end
end