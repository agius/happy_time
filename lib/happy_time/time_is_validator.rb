class TimeIsValidator < ActiveModel::EachValidator

  CHECKS = %w(before_now after_now now_or_earlier now_or_later before after at_or_before at_or_after)

  def check_validity!
    if options.nil? || options.keys.empty?
      raise ArgumentError, "No options provided. Must provide one of #{CHECKS.join(', ')}"
    end

    keys = options.keys.collect(&:to_s)
    if (keys - CHECKS).count > 0
      raise ArgumentError, "Invalid options: #{(options.keys - CHECKS).join(', ')}"
    end
  end

  def validate_each(record, attribute, value)
    return unless value.present?

    raise ArgumentError.new("No options specified for time_is: on #{record.class.name}") unless options.is_a?(Hash)

    now = Time.zone.now
    time_value = value

    if options[:before_now] && (time_value - now).to_i >= 0
      record.errors.add attribute, "is not before now"
    end

    if options[:after_now] && (time_value - now).to_i <= 0
      record.errors.add attribute, "is not afer now"
    end

    if options[:now_or_earlier] && (time_value - now).to_i >= 1
      record.errors.add attribute, "is later than now"
    end

    if options[:now_or_later] && (time_value - now).to_i <= -1
      record.errors.add attribute, "is earlier than now"
    end

    if options[:before]
      compare_to = options[:before]
      compare_to = record.read_attribute_for_validation(compare_to) if compare_to.is_a?(Symbol)
      compare_to = compare_to.to_time
      if (time_value - compare_to).to_i >= -1
        record.errors.add attribute, "is not before #{compare_to}"
      end
    end

    if options[:at_or_before]
      compare_to = options[:at_or_before]
      compare_to = record.read_attribute_for_validation(compare_to) if compare_to.is_a?(Symbol)
      compare_to = compare_to.to_time
      if (time_value - compare_to).to_i >= 1
        record.errors.add attribute, "is not on or before #{compare_to}"
      end
    end

    if options[:after]
      compare_to = options[:after]
      compare_to = record.read_attribute_for_validation(compare_to) if compare_to.is_a?(Symbol)
      compare_to = compare_to.to_time
      if (time_value - compare_to).to_i <= 1
        record.errors.add attribute, "is not after #{compare_to}"
      end
    end

    if options[:at_or_after]
      compare_to = options[:at_or_after]
      compare_to = record.read_attribute_for_validation(compare_to) if compare_to.is_a?(Symbol)
      compare_to = compare_to.to_time
      if (time_value - compare_to).to_i <= -1
        record.errors.add attribute, "is not on or after #{compare_to}"
      end
    end
  end
end