(function( $ ) {

  // use with time_zones_for_js helper
  $.tzAbbreviation = function() {
    var d = new Date(); 
    var tz_offset = d.getTimezoneOffset(); // seconds, not ms, because Javascript
    var abbr = $("span.happy-time-tz-info[data-offset='" + tz_offset + "']").data('abbreviation');
  }

  // use with Momentjs and format_time helper
  $.momentizeAll = function(){
    if(typeof(moment) === 'undefined' || !moment || moment == null){
      return;
    }
    $('[data-moment]').each( function(){
      $(this).momentize();
    });
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

  $.fn.momentize = function() {
    var utc_timestamp = parseInt($(this).data('moment'));
    var format = $(this).data('moment-format');
    if (utc_timestamp <= 0 || !format){
      return;
    }
    var date = new Date();
    var zone_offset = date.getTimezoneOffset();
    var span_moment = moment(utc_timestamp);
    if (zone_offset){
      span_moment.zone(zone_offset) if zone_offset;
    }
    $(this).html(span_moment.format(format))
  };

}( jQuery ));