module MatchesHelper

  # Get current playerdiv by id
  def get_playerdiv()
    playerdiv = Playerdiv.where(:player_id => current_player).last
    return playerdiv
  end




end
