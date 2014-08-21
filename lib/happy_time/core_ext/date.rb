class Date

  def happy(format_or_opts = nil, opts = {})
    HappyTime.format(self, format_or_opts, opts)
  end

  def to_html(format_or_opts = nil, opts = {})
    _format, _opts = HappyTime::TimeFormatter::Formatter.fetch_options(format_or_opts, opts)
    _opts[:html] = true if _opts[:html].nil?
    HappyTime.format(self, _format, _opts)
  end

end