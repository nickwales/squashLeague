class Playerdiv < ActiveRecord::Base
  attr_accessible :division_id, :player_id
  belongs_to :division
  has_many :matches
  has_many :players
end
