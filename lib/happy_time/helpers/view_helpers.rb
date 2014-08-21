module HappyTime
  module ViewHelpers

    @@time_zones_for_js = nil

    def format_time(time, format_or_opts = nil, opts = {})
      _format, _opts = TimeFormatter::Formatter.fetch_options(format_or_opts, opts)
      _opts[:html] = true if _opts[:html].nil?
      time_str = HappyTime.format(time, _format, _opts)
      time_str.html_safe
    end

    def js_timezone_select(selected = nil)
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
      ActiveSupport::TimeZone.all.reverse.each do |zone|
        next if prev_offsets.include?(zone.utc_offset)
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

    def time_zones_for_js
      return @@time_zones_for_js if @@time_zones_for_js.present?
      prev_offsets = []
      html = "<div style='display:none'>"
      time_zones = ActiveSupport::TimeZone.us_zones.reverse
      time_zones.each do |zone|
        next if prev_offsets.include?(zone.utc_offset)
        next unless zone.to_s =~ /Time/
        html << "<span class='happy-time-tz-info'
                  data-name='#{zone.name}'
                  data-abbreviation='#{zone.now.zone}'
                  data-offset='#{zone.tzinfo.period_for_utc(Time.now).utc_total_offset}'
                  >"
        html << "(GMT#{zone.formatted_offset}) #{zone.tzinfo.friendly_identifier}"
        html << "</span>"
        prev_offsets << zone.utc_offset
      end

      ActiveSupport::TimeZone.all.reverse.each do |zone|
        next if prev_offsets.include?(zone.utc_offset)
        html << "<span class='happy-time-tz-info'
                  data-name='#{zone.name}'
                  data-abbreviation='#{zone.now.zone}'
                  data-offset='#{zone.tzinfo.period_for_utc(Time.now).utc_total_offset}'
                  #{zone.to_s == selected ? 'selected=\'selected\'' : ''}>"
        html << "(GMT#{zone.formatted_offset}) #{zone.tzinfo.friendly_identifier}"
        html << "</span>"
        prev_offsets << zone.utc_offset
      end
      html << "</div>"
      @@time_zones_for_js = html.strip.gsub(/\s+/, ' ').html_safe
    end

  end
end