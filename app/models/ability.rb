# models/ability.rb
class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new # guest user
    #All user stuff goes here
    #
    #
    #

    

  
    if user.role? :admin
      can :manage, :all     
      
    end
    if user.role? :receipt_entry
      can [:read, :create], Receipt
    end

    if user.role? :camper_entry
      can [:edit, :create, :show], Camper
      can :show, Receipt
    end
  end
end
