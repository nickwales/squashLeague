class Ranking < ActiveRecord::Base
 # attr_accessible :match_id, :player_id, :score
  belongs_to :player
  belongs_to :match
end
