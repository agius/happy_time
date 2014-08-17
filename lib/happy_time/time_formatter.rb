module HappyTime
  module TimeFormatter

    DEFAULT_FORMAT = "%b %-d, %Y"

    @@moments = {}

    module_function

    def fetch_options(format_or_opts = nil, opts = {})
      format = nil
      format = format_or_opts if format_or_opts.is_a?(String) || format_or_opts.is_a?(Symbol)
      format = opts.delete(:format) if opts[:format].present?
      format = format.to_s if format.present?
      opts = opts.with_indifferent_access
      opts = format_or_opts.merge(opts).with_indifferent_access if format_or_opts.is_a?(Hash)
      [format, opts]
    end

    def format(time, format_or_opts = nil, opts = {})
      format, opts = fetch_options(format_or_opts, opts)

      time = 
        case time
        when Time   then time
        when Date   then time.to_time
        when String then defined?(Chronic) ? Chronic.parse(time) : Time.parse(time)
        else nil
        end

      unless time.present?
        return "".html_safe if opts[:html]
        return ""
      end

      format =
        case format
        when 'slash'              then '%-m/%-d/%Y'
        when 'xml', 'js', 'file'  then '%Y-%m-%d'
        when 'month'              then '%b %Y'
        when 'minute'             then '%a %b %e, %Y - %l:%M%P'
        when 'day'                then day_format(time)
        when 'short'              then short_format(time)
        else DEFAULT_FORMAT
        end

      format << " %Z" if opts[:timezone]

      if opts[:html]
        time_str = <<-HTML
        <span data-moment-format='#{to_moment(format)}'
              data-moment='#{time.to_i * 1000}'>
                #{time.strftime(format)}
         </span>
         HTML
      else
        time_str = time.strftime(format)
      end
      time_str.strip.gsub(/\s+/, ' ')
    end

    def day_format(time)
      if time > Time.zone.now.beginning_of_year && time < Time.zone.now.end_of_year
        '%b %-d'
      else
        DEFAULT_FORMAT
      end
    end

    def short_format(time)
      if time > Time.zone.now.beginning_of_day
        '%l:%M%P'
      elsif time > Time.zone.now - 1.weeks
        '%a'
      elsif time > Time.zone.now.beginning_of_year && time < Time.zone.now.end_of_year
        '%b %-d'
      else
        DEFAULT_FORMAT
      end
    end
    
    def to_moment(format)
      return @@moments[format] if @@moments[format].present?
      moment = format.dup
      moment.gsub!(/%Y/, 'YYYY')
      moment.gsub!(/%y/, 'YY')
      moment.gsub!(/%[_-]?m/, 'MM')
      moment.gsub!(/%\^?B/, 'MMMM')
      moment.gsub!(/%\^?[bh]/, 'MMM')
      moment.gsub!(/%-?[de]/, 'D')
      moment.gsub!(/%j/, 'DDDD')
      moment.gsub!(/%H/, 'HH')
      moment.gsub!(/%k/, 'H')
      moment.gsub!(/%I/, 'hh')
      moment.gsub!(/%l/, 'h')
      moment.gsub!(/%P/, 'a')
      moment.gsub!(/%p/, 'A')
      moment.gsub!(/%M/, 'mm')
      moment.gsub!(/%S/, 'ss')
      moment.gsub!(/%:*z/, 'ZZ')
      moment.gsub!(/%\^?a/, 'ddd')
      moment.gsub!(/%\^?A/, 'dddd')
      moment.gsub!(/%w/, 'e')
      moment.gsub!(/%u/, 'E')
      moment.gsub!(/%s/, 'X')
      moment.gsub!(/%n/, "\n")
      moment.gsub!(/%t/, "\t")
      moment.gsub!(/%%/, "%")
      @@moments[format.dup] = moment
    end
  end
end