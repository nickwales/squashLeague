class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  
  has_many :results
  has_many :playerdivs
  has_many :rankings
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :phone, :twitter, :password, :password_confirmation, :remember_me, :admin, :active
  # attr_accessible :title, :body
end
