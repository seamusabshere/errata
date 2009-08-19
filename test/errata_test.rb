require 'test_helper'

class Brewery
  def self.is_microbrew?(row)
    row[:volume] < 500
  end
end

class ErrataTest < Test::Unit::TestCase
  def setup
    @e = Errata.new(:url => 'http://static.brighterplanet.com/science/data/transport/automobiles/make_fleet_years/errata.csv')
  end
  
  should "return implied matching methods" do
    flunk "create a fake errata for Brewery"
  end
  
  should "use matching methods" do
    flunk "create a fake errata for Brewery"
  end
  
  should "correct rows" do
    rover = { 'manufacturer_name' => 'foobar Austin Rover foobar' }
    mercedes = { 'manufacturer_name' => 'MERCEDES' }
    @e.correct!(mercedes)
    @e.correct!(rover)
    assert_equal 'Mercedes-Benz', mercedes['manufacturer_name']
    assert_equal 'Rover',         rover['manufacturer_name']
  end
  
  should "reject rows" do
    assert @e.rejects?('manufacturer_name' => 'AURORA CARS')
  end
end
