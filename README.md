# HappyTime

Dealing with times and time zones on any platform is a major pain. In Ruby on Rails, you have to coordinate Time, ActiveSupport::TimeWithZone, your database's time zone setting, the time zone setting on all your servers, the time zone settings on your development machine (for tests), and the time zone in your users' browser. Getting them all to agree is tough.

HappyTime is a set of helpers and syntax sugar to make this tangled knot a little easier.

## Installation

Add this line to your application's Gemfile:

    gem 'happy_time'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install happy_time

**Not required, but a really good idea**

* Make sure all your app's servers are set to UTC.
* Make sure all your databases are set to UTC.
* Make sure `Time.zone = "UTC"` is in an initializer or environment file in your app.
* If you are using [Chronic](https://github.com/mojombo/chronic), make sure `Chronic.time_class = Time.zone` is in an initializer or environment file in your app.
* If you aren't using [MomentJS](momentjs.com), you can install it via Bower, or the [momentjs-rails](https://github.com/derekprior/momentjs-rails) gem.

## Usage

HappyTime makes things easier across your app. It's not a replacement for anything, but it just adds bits of functionality here and there. Let's have a look:

### Time Zone Names

    ActiveSupport::TimeZone.names

Gives you a quick and easy list of all the named time zones that ActiveSupport works with.

### Validations

    class AppEvent < ActiveRecord::Base
      validates :past_time,     time_is: { before_now: true }
      validates :future_time,   time_is: { after_now: true }
      validates :now_or_before, time_is: { now_or_earlier: true }
      validates :now_or_after,  time_is: { now_or_later: true }
      validates :after_past,    time_is: { after: :past_time }
      validates :before_future, time_is: { before: :future_time }
      validates :before_or_at,  time_is: { at_or_before: :past_time }
      validates :after_or_at,   time_is: { at_or_later: :future_time }
      validates :other_past,    time_is: { before: Proc.new(Time.parse("Thu Nov 25 15:00:00 2010")) }
      validates :other_future,  time_is: { after: "past_time" }
    end

This makes time validation easier, and avoids the easiest pitfall: [Ruby tracking time to the nanosecond](http://stackoverflow.com/questions/21892953/time-comparison-with-activesupport-failed). While nanoseconds are not too much of an issue in production, they can be extremely frustrating in tests.

### Time Zone selector

    /views/app_events/_app_event.html.erb
    <%= select_tag :time_zone, js_timezone_select(Time.zone) %>

This will give you a nice select box for time zones. 

* The values are pulled from [TZInfo](https://github.com/tzinfo/tzinfo) via [ActiveSupport](https://github.com/rails/rails/tree/master/activesupport)
* Values work with built-in functions like `Time.use_zone`
* There's only one option per time zone, and GMT offset is displayed
* Each `<option>` tag includes `data-abbreviation` and `data-offset`, which are useful for your app's client-side functionality.

### Formatting

    /views/app_events/_app_event.html.erb
    <%= format_time(Time.now) %> 
    <span data-moment-format="MMM D YYYY"
          data-moment="438710400">
      Nov 26, 1983
    </span>

    <%= format_time(Time.now, 'short') %> 
    <span data-moment-format="h:mma"
          data-moment="438710400">
      4:00pm
    </span>

    <%= format_time(Time.now, 'short', html: false) %> 
    4:00pm

    <%= format_time(Time.now, format: 'short', html: false) %> 
    4:00pm

Displays dates and times in a nice format. HappyTime by default will wrap the displayed time in a `<span>` tag with some info for the amazing [Moment.js](http://momentjs.com). This makes it easy to convert times from your server's time zone into the browser's time zone while retaining the same format. HappyTime will take care of the translation for you.

The following formats are supported:

    'slash'               11/26/1983 Good for jQuery UI's datepicker widget
    'xml', 'js', 'file'   1983-11-26 Output for json, filenames, etc
    'month'               Nov 1983
    'minute'              Sat Nov 26, 1983 - 4:00pm
    'day'                 Nov 26
                          Nov 26, 1982 if the time is before the beginning of the current year
    'short'               4:00pm if the time is from today
                          Thu if the time is before today, but less than one week ago
                          Nov 26 if the time is more than one week ago
                          Nov 26, 1982 if the time is before the beginning of the current year

You can also use this functionality server-side via `TimeFormatter.format(Time.zone.now, 'short')`

### jQuery

If you use jQuery, there's a useful helper file you can include in your application.js:

    /app/assets/javascript/application.js
    ...
    //= require jquery.selected-tz
    ...

This gives you some useful functions for your client-side code.

    // Gets the abbreviation for the selected timezone - i.e. "EST"
    $("#app_event_time_zone").tzAbbreviation();

    // converts span from our helper above into the browser's time zone via Moment
    $(".moments span:first").momentize();
    
    // transforms all formatted times on the page using MomentJS
    $(document).on('ready', 'page:load', function(){
      $.momentizeAll();
    });

There's one other view helper, which you can use in your site's header or footer: `<%= time_zones_for_js %>` This outputs some hidden HTML containing the same data attributes as the options tags. And don't worry, it's memoized. Then you can use a very simple jQuery function to get the browser's time zone abbreviation:

    $.tzAbbreviation() // "EST"

### Matchers

If you use [RSpec](https://relishapp.com/rspec), HappyTime includes matchers similar to the validations above. Useful for making time comparisons clear, and avoiding the nanosecond pitfall.

    /models/app_event_spec.rb
    now = Time.zone.now
    expect(app_event.current_time).to   be_time(now) # less than 1sec difference
    expect(app_event.past_time).to      be_before(now)
    expect(app_event.future_time).to    be_after(now)
    expect(app_event.now_or_before).to  be_at_or_before(now)
    expect(app_event.now_or_after).to   be_at_or_after(now)

## Contributing

1. Fork it ( https://github.com/[my-github-username]/happy_time/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
