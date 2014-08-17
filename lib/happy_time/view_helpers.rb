module HappyTime
  module ViewHelpers

    def js_timezones(selected)
      prev_offsets = []
      html = ""
      time_zones = ActiveSupport::TimeZone.us_zones.reverse
      time_zones.each do |zone|
        next if prev_offsets.include?(zone.utc_offset)
        next unless zone.to_s =~ /Time/
        html << "<option value='#{zone.name}'
                  data-abbreviation='#{zone.now.zone}'
                  data-offset='#{zone.tzinfo.period_for_utc(Time.now).utc_total_offset}'
                  #{zone.name == selected ? 'selected=\'selected\'' : ''}>" # use milliseconds for js
        html << "(GMT#{zone.formatted_offset}) #{zone.tzinfo.friendly_identifier}"
        html << "</option>"
        prev_offsets << zone.utc_offset
      end

      html << "<option disabled='disabled'>--------------</option>"
      ActiveSupport::TimeZone.all.each do |zone|
        next if prev_offsets.include?(zone.name)
        html << "<option value='#{zone.name}'
                  data-abbreviation='#{zone.now.zone}'
                  data-offset='#{zone.tzinfo.period_for_utc(Time.now).utc_total_offset}'
                  #{zone.to_s == selected ? 'selected=\'selected\'' : ''}>"
        html << "(GMT#{zone.formatted_offset}) #{zone.tzinfo.friendly_identifier}"
        html << "</option>"
        prev_offsets << zone.utc_offset
      end

      html.html_safe
    end

  end
end