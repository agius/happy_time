require 'spec_helper'

describe HappyTime::ViewHelpers do
  include ActionView::Helpers
  include HappyTime::ViewHelpers

  it 'should render js_timezone select' do
    Time.use_zone("UTC") do
      html = js_timezones
      expect(html).to match(/value='UTC'/m), "Didn't find London"
      expect(html).to match(/data-abbreviation='UTC'/m), "Didn't find abbreviation GMT"
      offset = /data-offset='0'/m
      expect(html).to match(offset), "Didn't find offset 0"
      expect(html.scan(offset).count).to eq(1)
      expect(html).to match(/\(GMT\+00:00\) Etc - UTC/m), "Didn't find GMT+00:00"
    end
  end

end