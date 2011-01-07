require 'test_helper'

class PossibleIssueTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert PossibleIssue.new.valid?
  end
end
