require 'test_helper'

class BusTest < ActiveSupport::TestCase
  test "can save a basic bus" do
    b = Factory.build(:bus)
    assert b.valid?
    assert b.save
  end
  
  
  test "cant save a bus without a capacity" do
    b = Factory.build(:bus, :capacity=>nil)
    assert !b.valid?
  end
  
  
  test "current load is correct" do
    b = Factory.create(:bus)
    assert_equal b.current_load, 0
    assert_difference 'b.current_load' do
      c = Factory.create(:camper, :bus_id=>b.id)
    end
  end
  
  
  test "seats remaining" do
    b = Factory.create(:bus, :capacity=>15)
    assert_equal b.seats_remaining, 15
    assert_difference 'b.seats_remaining', -1 do
       c = Factory.create(:camper, :bus_id=>b.id)
     end
  end

  
end