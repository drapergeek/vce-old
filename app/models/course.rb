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
