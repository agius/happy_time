# compare times using integer differences
# gets rid of timezone issues and nanosecond comparison
module HappyTime
  module Matchers
    class TimeMatcher
      TIME_FORMAT = '%b %-d, %Y %H:%M:%S %N %z'

      def initialize(expected)
        raise ArgumentError.new("Cannot convert #{expected} to Time") unless expected.respond_to?(:to_time)
        @expected = expected.to_time
      end

      def set_actual_time(actual)
        @actual = actual.to_time if actual.respond_to?(:to_time)
        @actual ||= actual
      end

      def matches?(actual)
        set_actual_time
        @expected.is_a?(Time) && @actual.is_a?(Time)
      end

      def failure_message
        if !@expected.is_a?(Time)
          "expected value #{@expected} cannot be converted to time"
        elsif !@actual.is_a?(Time)
          "actual value #{@actual} cannot be converted to time"
        else
          time_failure_message
        end
      end

      def failure_message_when_negated
        if !@expected.is_a?(Time)
          "expected value #{@expected} can be converted to time"
        elsif !@actual.is_a?(Time)
          "actual value #{@actual} can be converted to time"
        else
          time_failure_negated_message
        end
      end

      def time_failure_message
        "expected #{@actual} and #{@expected} would both be convertible to Time"
      end
      
      def time_failure_negated_message
        "expected #{@actual} or #{@expected} would not be convertible to Time"
      end
    end

    def be_a_time(expected)
      TimeMatcher.new(expected)
    end
  end
end
