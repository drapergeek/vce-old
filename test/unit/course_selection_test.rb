require File.dirname(__FILE__) + '/../test_helper'

class CourseSelectionTest < Test::Unit::TestCase
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: course_selections
#
#  id         :integer         not null, primary key
#  camper_id  :integer
#  course_id  :integer
#  preference :integer
#

