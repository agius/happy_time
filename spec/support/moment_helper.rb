def js_span(js_format, microseconds, formatted)
  _span = <<-HTML
    <span data-moment-format='#{js_format}'
            data-moment='#{microseconds}'>
              #{formatted}
    </span>
  HTML
  _span.strip.gsub(/\s+/, ' ')
end