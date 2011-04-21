# models/ability.rb
class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new # guest user
    #All user stuff goes here
    #
    #
    #

    

    can :manage, :all
    if user.role? :admin
      can :manage, :all     
      
    end
  end
end
