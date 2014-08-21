module HappyTime
  module TimeFormatter
    class Formatter
      include HappyTime::Concerns::Configurable
      extend ActionView::Helpers::TagHelper
      extend ActionView::Helpers::DateHelper

      attr_accessor :time, :format, :options

      class << self
        def fetch_options(format_or_opts = nil, opts = {})
          format = nil
          format = format_or_opts if format_or_opts.is_a?(String) || format_or_opts.is_a?(Symbol)
          format = opts.delete(:format) if opts[:format].present?
          format ||= :default
          format = format.to_s if format.present?
          opts = opts.with_indifferent_access
          opts = format_or_opts.merge(opts).with_indifferent_access if format_or_opts.is_a?(Hash)
          [format, opts]
        end

        def format(time, format_or_opts = nil, opts = {})
          format, opts = fetch_options(format_or_opts, opts)

          time = 
            case time
            when Time   then time.dup
            when Date   then time.to_time
            when String then defined?(Chronic) ? Chronic.parse(time) : Time.parse(time)
            else nil
            end

          unless time.present?
            return "".html_safe if opts[:html]
            return ""
          end

          time = time.in_time_zone(opts[:zone]) if opts[:zone]

          out_format = configuration.formats[format]
          out_format = send(out_format, time) if out_format.is_a?(Symbol)
          out_format = out_format.call(time) if out_format.is_a?(Proc)
          out_format << " %Z" if opts[:timezone]

          html_opts = {
            data: {
              moment_format: to_moment(out_format),
              moment: time.in_time_zone("UTC").to_i * 1000
            }
          }
          html_opts.merge!(opts[:html]) if opts[:html].is_a?(Hash)

          time_str = time.strftime(out_format).strip
          time_str = content_tag(configuration.tag, time_str, html_opts) if opts[:html]
          time_str.strip.gsub(/\s+/, ' ')
        end

        def to_moment(format)
          Momentizer.to_moment(format)
        end

        def day_format(time)
          if time > Time.zone.now.beginning_of_year && time < Time.zone.now.end_of_year
            configuration.formats[:month_day]
          else
            configuration.formats[:month_day_year]
          end
        end

        def short_format(time)
          if time > Time.zone.now.beginning_of_day
            configuration.formats[:hour_minute]
          elsif time > Time.zone.now - 1.weeks
            configuration.formats[:weekday]
          elsif time > Time.zone.now.beginning_of_year && time < Time.zone.now.end_of_year
            configuration.formats[:month_day]
          else
            configuration.formats[:month_day_year]
          end
        end

        def ago_format(time)
          time_ago_in_words(time)
        end
      end # end class << self
    end  # end Formatter
  end
end