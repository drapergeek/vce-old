require 'spec_helper'

describe Pack do
  it { should have_many(:rooms) }
  it { should have_many(:campers).through(:rooms) }
end
