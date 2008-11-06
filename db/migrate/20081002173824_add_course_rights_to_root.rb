class AddCourseRightsToRoot < ActiveRecord::Migration
  def self.up
    role = Role.find_by_name('root')
    course_rights = Array.new
    course_rights.push(Right.create :name=>'List all courses', :controller=>'courses', :action=>'index')
    course_rights.push(Right.create :name=>'List all courses', :controller=>'courses', :action=>'list')
    course_rights.push(Right.create :name=>'Show a single course', :controller=>'courses', :action=>'show')
    course_rights.push(Right.create :name=>'View the new course screen', :controller=>'courses', :action=>'new')
    course_rights.push(Right.create :name=>'Create a new course', :controller=>'courses', :action=>'create')
    course_rights.push(Right.create :name=>'Show the edit crouse screen', :controller=>'courses', :action=>'edit')
    course_rights.push(Right.create :name=>'Update a course', :controller=>'courses', :action=>'update')
    course_rights.push(Right.create :name=>'Delete a course', :controller=>'courses', :action=>'destroy')
    
    course_rights.each do |c|
      role.rights<<c
    end
    
  end

  def self.down
    
  end
end
