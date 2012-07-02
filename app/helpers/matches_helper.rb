module MatchesHelper

  # Gets everyone apart from the chosen player, and puts it in an array.
  def other_playerdiv_players_array(division,player_id)
    players = Array.new
    results = Player.joins(:playerdivs).where(:playerdivs => {:division_id => division}).where("players.id != ?", player_id)
    results.each do |r|
      players << [r.name, r.id]
    end
    return players
  end
  
  # Get everyone we haven't played yet this division  
  def unplayed_playerdiv_players(division,player_id)
    #Get everyone who isn't us
    others = other_playerdiv_players_array(division,player_id)
    #Get the ones we've played against
    played = get_division_matches_played(division,player_id)
    #Subtract one from the other
    unplayed = others - played
    #Put it in a hash and grab the name.
    unplayedWithName = Hash.new
    unplayed.each do |u|
      unplayedWithName[player_by_id(p).name] = p
    end
    return unplayedWithName
  end
  
  # Get current playerdiv by id
  def get_playerdiv()
    playerdiv = Playerdiv.where(:player_id => current_player).last
    return playerdiv
  end




end
