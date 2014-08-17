(function( $ ) {

  // use with time_zones_for_js helper
  $.tzAbbreviation = function() {
    var d = new Date(); 
    var tz_offset = d.getTimezoneOffset(); // seconds, not ms, because Javascript
    var abbr = $("span.happy-time-tz-info[data-offset='" + tz_offset + "']").data('abbreviation');
  }

  // use with select_tag and js_timezones helper
  $.fn.tzAbbreviation = function() {
    if($(this).children('option[data-offset]').length == 0){
      return $(this);
    }
    var d = new Date(); 
    var tz_offset = d.getTimezoneOffset(); // seconds, not ms, because Javascript
    var abbr = $(this).find("option[data-offset='" + tz_offset + "']").data('abbreviation');
    return abbr;
  };
}( jQuery ));