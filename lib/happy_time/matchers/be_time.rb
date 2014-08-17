module HappyTime
  module Matchers
    class BeTime < TimeMatcher
      def matches?(actual)
        set_actual_time(actual)
        @expected == @actual || (
          (@expected - @actual).floor < 1 && 
          (@expected - @actual).floor > -1
        )
      end

      def time_failure_message
        "expected #{actual.strftime(TIME_FORMAT)} would be #{expected.strftime(TIME_FORMAT)}"
      end

      def time_failure_negated_message
        "expected #{@actual.strftime(TIME_FORMAT)} would not be #{@expected.strftime(TIME_FORMAT)}"
      end
    end

    def be_time(expected)
      BeTime.new(expected)
    end
  end
end
