class CourseSelection < ActiveRecord::Base
  belongs_to :course
  belongs_to :camper
end
