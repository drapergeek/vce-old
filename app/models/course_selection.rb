class CourseSelection < ActiveRecord::Base
  belongs_to :course
  belongs_to :camper
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

