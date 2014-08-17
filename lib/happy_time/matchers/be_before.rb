module HappyTime
  module Matchers
    class BeBefore < TimeMatcher
      def matches?(actual)
        set_actual_time(actual)
        (@expected - @actual).floor > 0
      end

      def time_failure_message
        "expected #{@actual.strftime(TIME_FORMAT)} would be before #{@expected.strftime(TIME_FORMAT)}"
      end

      def time_failure_negated_message
        "expected #{@actual.strftime(TIME_FORMAT)} would not be before #{@expected.strftime(TIME_FORMAT)}"
      end
    end

    def be_before(expected)
      BeBefore.new(expected)
    end
  end
end