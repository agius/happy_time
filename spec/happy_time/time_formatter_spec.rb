require 'spec_helper'

module HappyTime
  describe TimeFormatter do
    let(:formatter){ HappyTime::TimeFormatter }
    let(:configuration){ HappyTime.configuration }
    let(:now){ Time.zone.now }

    before do
      @original_zone = Time.zone
      Time.zone = "UTC"
      Timecop.freeze(Time.zone.parse("Thu Nov 25 15:00:00 2010"))
    end

    after do
      Timecop.return
      Time.zone = @original_zone
    end

    describe "plain formats" do

      specify 'default' do
        expect(formatter.format(now)).to eq("Nov 25, 2010")
      end

      specify 'slashed format compatible with jQuery UI datepicker' do
        expect(formatter.format(now, :slash)).to eq("11/25/2010")
      end

      specify 'dashed format for js, xml, and filenames' do
        expect(formatter.format(now, :js)).to eq("2010-11-25")
        expect(formatter.format(now, :xml)).to eq("2010-11-25")
        expect(formatter.format(now, :file)).to eq("2010-11-25")
      end

      specify 'month only', focus: true do
        expect(formatter.format(now, :month)).to eq("Nov 2010")
      end

      specify 'minute' do
        expect(formatter.format(now, :minute)).to eq("Thu Nov 25, 2010 - 3:00pm")
      end

      specify 'variable day format' do
        expect(formatter.format(now, :day)).to eq("Nov 25")
        expect(formatter.format(now - 1.years, :day)).to eq("Nov 25, 2009")
      end

      specify "variable short format" do
        expect(formatter.format(now - 3.minutes, :short)).to eq("2:57pm")
        expect(formatter.format(now - 2.days, :short)).to eq("Tue")
        expect(formatter.format(now - 1.years, :short)).to eq("Nov 25, 2009")
      end

    end

    describe 'html span formats' do
      let(:micro){ now.to_i * 1000 }

      specify 'default' do
        html = js_span("MMM D, YYYY", micro, "Nov 25, 2010")
        expect(formatter.format(now, html: true)).to eq(html)
      end

      specify 'slashed format compatible with jQuery UI datepicker' do
        html = js_span("MM/D/YYYY", micro, "11/25/2010")
        expect(formatter.format(now, :slash, html: true)).to eq(html)
      end

      specify 'dashed format for js, xml, and filenames' do
        html = js_span("YYYY-MM-D", micro, "2010-11-25")
        expect(formatter.format(now, :js, html: true)).to eq(html)
        expect(formatter.format(now, :xml, html: true)).to eq(html)
        expect(formatter.format(now, :file, html: true)).to eq(html)
      end

      specify 'month only' do
        html = js_span("MMM YYYY", micro, "Nov 2010")
        expect(formatter.format(now, :month, html: true)).to eq(html)
      end

      specify 'minute' do
        html = js_span("ddd MMM D, YYYY - h:mma", micro, "Thu Nov 25, 2010 - 3:00pm")
        expect(formatter.format(now, :minute, html: true)).to eq(html)
      end

      specify 'variable day format' do
        html = js_span("MMM D", micro, "Nov 25")
        expect(formatter.format(now, :day, html: true)).to eq(html)

        html = js_span("MMM D, YYYY", (now - 1.years).to_i * 1000, "Nov 25, 2009")
        expect(formatter.format(now - 1.years, :day, html: true)).to eq(html)
      end

      specify "variable short format" do
        html = js_span("h:mma", (now - 3.minutes).to_i * 1000, "2:57pm")
        expect(formatter.format(now - 3.minutes, :short, html: true)).to eq(html)
        
        html = js_span("ddd", (now - 2.days).to_i * 1000, "Tue")
        expect(formatter.format(now - 2.days, :short, html: true)).to eq(html)
        
        html = js_span("MMM D, YYYY", (now - 1.years).to_i * 1000, "Nov 25, 2009")
        expect(formatter.format(now - 1.years, :short, html: true)).to eq(html)
      end

    end

    describe "custom formats" do

      before do
        HappyTime.configure do |config|
          config.formats[:iso] = '%FT%T%:z'
        end
      end

      after do
        HappyTime.reset!
      end

      specify 'ISO format' do
        expect(formatter.format(now, :iso)).to eq("2010-11-25T15:00:00+00:00")
      end

      specify 'ISO format html' do
        html = js_span("ddd", (now - 2.days).to_i * 1000, "Tue")
        expect(formatter.format(now - 2.days, :short, html: true)).to eq(html)
      end

    end

    describe 'different tag' do

      before do
        HappyTime.configure do |config|
          config.tag = 'time'
        end
      end

      after do
        HappyTime.reset!
      end

      specify 'uses custom tag in output' do
        html = formatter.format(now, html: true)
        expect(html).to match(/time/)
        expect(html).to_not match(/span/)
      end

    end

  end # end describe
end