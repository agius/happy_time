require 'spec_helper'

describe HappyTime::ViewHelpers do
  include ActionView::Helpers
  include HappyTime::ViewHelpers

  before do
    @original_zone = Time.zone
    Time.zone = "UTC"
  end

  after do
    Time.zone = @original_zone
  end

  it 'should render js_timezone select' do
    html = js_timezone_select
    expect(html).to match(/value='UTC'/m), "Didn't find London"
    expect(html).to match(/data-abbreviation='UTC'/m), "Didn't find abbreviation GMT"
    offset = /data-offset='0'/m
    expect(html).to match(offset), "Didn't find offset 0"
    expect(html.scan(offset).count).to eq(1)
    expect(html).to match(/\(GMT\+00:00\) Etc - UTC/m), "Didn't find GMT+00:00"
  end

  it 'should output moment-ready span by default' do
    html = format_time(Time.now)
    expect(html).to match(/span/)
    expect(html).to match(/data-moment-format/)
    expect(html).to match(/data-moment/)
  end

  it 'should not output moment-ready span if specified' do
    html = format_time(Time.now, html: false)
    expect(html).to_not match(/span/)
    expect(html).to_not match(/data-moment-format/)
    expect(html).to_not match(/data-moment/)
  end

end