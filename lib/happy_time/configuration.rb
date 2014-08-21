module HappyTime
  class Configuration

    FORMATS = {
      slash:            '%-m/%-d/%Y',
      xml:              '%Y-%m-%d',
      js:               '%Y-%m-%d',
      file:             '%Y-%m-%d',
      month:            '%b %Y',
      minute:           '%a %b %e, %Y - %l:%M%P',
      month_day:        '%b %-d',
      month_day_year:   '%b %-d, %Y', 
      day:              :day_format,
      hour_minute:      '%l:%M%P',
      weekday:          '%a',
      short:            :short_format,
      ago:              :ago_format,
      default:          '%b %-d, %Y'
    }.with_indifferent_access

    TAG = 'span'

    MOMENT_MAPS = {
      /%Y/ => 'YYYY',
      /%y/ => 'YY',
      /%[_-]?m/ => 'MM',
      /%\^?B/ => 'MMMM',
      /%\^?[bh]/ => 'MMM',
      /%-?[de]/ => 'D',
      /%j/ => 'DDDD',
      /%H/ => 'HH',
      /%k/ => 'H',
      /%I/ => 'hh',
      /%l/ => 'h',
      /%P/ => 'a',
      /%p/ => 'A',
      /%M/ => 'mm',
      /%S/ => 'ss',
      /%T/ => 'HH:mm:ss',
      /%X/ => 'HH:mm:ss',
      /%:*z/ => 'ZZ',
      /%\^?a/ => 'ddd',
      /%\^?A/ => 'dddd',
      /%w/ => 'e',
      /%u/ => 'E',
      /%s/ => 'X',
      /%n/ => "\n",
      /%t/ =>  "\t",
      /%%/ => "%"
    }

    HTML_OPTIONS = {
      class: 'momentjs'
    }.with_indifferent_access

    attr_accessor :formats, :tag, :moment_maps, :html_options

    def initialize
      @formats = FORMATS.dup
      @tag = TAG.dup
      @moment_maps = MOMENT_MAPS.dup
      @html_options = HTML_OPTIONS.dup
      self
    end
  end
end