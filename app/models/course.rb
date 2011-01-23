class Course < ActiveRecord::Base
  validates_presence_of :name
  has_many :course_selections
  has_many :campers, :through=> :course_selections
  belongs_to :unit
  
  
  def self.find_standard_courses(options={})
        with_scope :find => options do 
          find(:all, :conditions=>['unit_id like ?', Thread.current["unit"].id])
      end
    end
end

# == Schema Information
#
# Table name: courses
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  unit_id     :integer
#  created_at  :datetime
#

