require 'spec_helper'

describe Room do
  it { should have_many(:campers) }
  it { should belong_to(:pack) }
end
