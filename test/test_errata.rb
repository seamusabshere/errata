require 'helper'
require 'models'

describe Errata do
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
