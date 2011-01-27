require 'test_helper'

class AnnoucementTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: annoucements
#
#  id         :integer         not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  message    :text
#  starts_at  :datetime
#  ends_at    :datetime
#

