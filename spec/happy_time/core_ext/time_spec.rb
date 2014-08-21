require 'spec_helper'

describe Time do

  let(:now){ Time.zone.now }
  let(:micro){ now.to_i * 1000 }

  before do
    @original_zone = Time.zone
    Time.zone = "UTC"
    Timecop.freeze(Time.zone.parse("Thu Nov 25 15:00:00 2010"))
  end

  after do
    Timecop.return
    Time.zone = @original_zone
  end

  specify '#to_html' do
    html = js_span("MMM D, YYYY", micro, "Nov 25, 2010")
    expect(now.to_html).to eq(html)
  end

  specify '#happy' do
    expect(now.happy).to eq("Nov 25, 2010")
  end

end