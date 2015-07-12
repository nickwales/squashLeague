class Result < ActiveRecord::Base
  belongs_to :player
  belongs_to :match, :inverse_of => :results
  validates_presence_of :score, :message=>"Not a valid score"
 # attr_accessible :active, :match_id, :points, :result, :score, :player_id
end