class Pack < ActiveRecord::Base
  has_many :campers
  belongs_to :unit
  
  def self.find_standard_packs(options={})
        with_scope :find => options do 
          year = Date.today.year
          find(:all, :conditions=>['unit_id like ?', Thread.current["unit"].id])
      end
    end
end

# == Schema Information
#
# Table name: packs
#
#  id      :integer         not null, primary key
#  name    :string(255)
#  unit_id :integer
#

