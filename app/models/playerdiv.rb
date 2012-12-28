class Playerdiv < ActiveRecord::Base
  attr_accessible :division_id, :player_id
  belongs_to :division
  has_many :matches
  belongs_to :player
end
