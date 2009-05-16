class AddValidateActionForReceipts < ActiveRecord::Migration
  def self.up
    role = Role.find_by_name('root')
    validation_right = Array.new
    validation_right.push(Right.create :name=>'Live validation of camper_id(MUST BE ENABLED FOR ALL)', :controller=>'receipts', :action=>'validate')
    validation_right.each do |r|
      role.rights<<r
    end
    
  end

  def self.down
  end
end
