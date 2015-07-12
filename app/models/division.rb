class Division < ActiveRecord::Base
 # attr_accessible :name, :number, :season_id
  has_many :playerdivs
  
  class Ability
    include CanCan::Ability
    def initialize(user)
      can :read, :all                   # allow everyone to read everything
      if player && player.admin?
        can :access, :rails_admin       # only allow admin users to access Rails Admin
        can :dashboard                  # allow access to dashboard
        can :manage, :all             # allow superadmins to do anything
    #    can :manage, [User, Product]  # allow managers to do anything to products and users
    #    can :update, Product, :hidden => false  # allow sales to only update visible products
      end
    end
  end
  
end
