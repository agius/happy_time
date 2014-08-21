require 'spec_helper'

describe HappyTime do

  describe 'set config vars' do
    specify 'formats' do
      HappyTime.configuration.formats[:iso] = '%FT%T%:z'
      expect(HappyTime.configuration.formats[:iso]).to eq('%FT%T%:z')
      expect(HappyTime.configuration.formats['iso']).to eq('%FT%T%:z')
      
      HappyTime.reset!
      expect(HappyTime.configuration.formats[:iso]).to be_nil
      expect(HappyTime.configuration.formats['iso']).to be_nil
    end

    specify 'tag' do
      HappyTime.configuration.tag = 'time'
      expect(HappyTime.configuration.tag).to eq('time')

      HappyTime.reset!
      expect(HappyTime.configuration.tag).to eq('span')
    end

    specify 'html options' do
      HappyTime.configuration.html_options[:role] = 'time'
      expect(HappyTime.configuration.html_options[:role]).to eq('time')
      expect(HappyTime.configuration.html_options['role']).to eq('time')

      HappyTime.reset!
      expect(HappyTime.configuration.html_options[:role]).to be_nil
      expect(HappyTime.configuration.html_options['role']).to be_nil
      expect(HappyTime.configuration.html_options).to eq(HappyTime::Configuration::HTML_OPTIONS)
    end
  end

  specify 'zone names' do
    expect(HappyTime.zone_names.count).to eq(ActiveSupport::TimeZone.all.count)
    expect(HappyTime.zone_names).to include("UTC")
  end

end