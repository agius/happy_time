module HappyTime
  module Matchers
    class BeAtOrBefore < TimeMatcher
      def matches?(actual)
        set_actual_time(actual)
        (@expected - @actual).floor > -1
      end

      def time_failure_message
        "expected #{@actual.strftime(TIME_FORMAT)} would be at or before #{@expected.strftime(TIME_FORMAT)}"
      end

      def time_failure_negated_message
        "expected #{@actual.strftime(TIME_FORMAT)} would not be at or before #{@expected.strftime(TIME_FORMAT)}"
      end
    end

    def be_at_or_before(expected)
      BeAtOrBefore.new(expected)
    end
  end
end