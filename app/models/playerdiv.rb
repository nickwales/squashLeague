class Playerdiv < ActiveRecord::Base
  #attr_accessible :division_id, :player_id
  belongs_to :division
  belongs_to :player

  validates_uniqueness_of :player_id, :scope => :division_id
end
