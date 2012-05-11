require 'helper'
require 'models'

describe Errata do
  describe 'without responder' do
    it "doesn't require a responder" do
      e = Errata.new :url => 'https://docs.google.com/spreadsheet/pub?key=0AkCJNpm9Ks6JdHEtemF2YTZzdGRYbE1MTHFMRXpRUHc&single=true&gid=0&output=csv'
      row = { 'name' => 'denver intl airport' }
      e.correct! row
      row['name'].must_equal 'denver International airport'
    end
  end

  describe 'with conditions' do
    it "uses a responder to answer conditions" do
      eval %{
        class ColoradoGuru
          def is_denver_airport?(record)
            record['name'].to_s.downcase.include? 'denver'
          end
        end
      }
      e = Errata.new(
        :url => 'https://docs.google.com/spreadsheet/pub?key=0AkCJNpm9Ks6JdG9PcFBjVnE4SGpLVXNTakVhSFY2VFE&single=true&gid=0&output=csv',
        :responder => 'ColoradoGuru'
      )
      row = { 'name' => 'denver intl airport' }
      e.correct! row
      row['name'].must_equal 'denver International airport' # matched condition
      row = { 'name' => 'madison intl airport' }
      e.correct! row
      row['name'].must_equal 'madison intl airport' # didn't match
    end

    it "blows up if you have conditions but no responder" do
      e = Errata.new :url => 'https://docs.google.com/spreadsheet/pub?key=0AkCJNpm9Ks6JdG9PcFBjVnE4SGpLVXNTakVhSFY2VFE&single=true&gid=0&output=csv'
      row = { 'name' => 'denver intl airport' }
      lambda do
        e.correct! row
      end.must_raise ArgumentError, /conditions.*used/i
    end
  end

  describe 'to correct automobile model details' do
    before do
      @e = Errata.new :url => 'http://spreadsheets.google.com/pub?key=t9WkYT39zjrStx7ruCFrZJg',
                      :responder => 'AutomobileVariantGuru'
    end
      
    it "corrects rows" do
      alfa = { "carline_mfr_name"=>"ALFA ROMEO" }
      @e.correct!(alfa)
      alfa['carline_mfr_name'].must_equal 'Alfa Romeo'
    end
    
    it "rejects rows" do
      @e.rejects?('carline_mfr_name' => 'AURORA CARS').must_equal true
    end
      
    it "tries multiple conditions" do
      bentley = { 'carline_mfr_name' => 'ROLLS-ROYCE BENTLEY', "carline name" => 'Super Bentley' }
      @e.correct!(bentley)
      bentley['carline_mfr_name'].must_equal 'Bentley'
    end
  end
end
