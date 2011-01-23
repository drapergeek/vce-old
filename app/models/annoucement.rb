class Annoucement < ActiveRecord::Base
  
  def self.current_announcements(hide_time)
    #with_scope :find => { :conditions => "starts_at <= now() AND ends_at >= now()" } do
     # if hide_time.nil?
      #  find(:all)
    #  else
    #    find(:all)
    #    find(:all, :conditions => ["updated_at > ? OR starts_at > ?", hide_time, hide_time])
    #  end
    #end
    return Array.new
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

