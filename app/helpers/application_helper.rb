module ApplicationHelper

   def logo
    base_logo = image_tag("logo.png", :alt => "Sample App", :class => "round")
   end

  # Return a title on a per-page basis
   def title
    base_title = "This is the title"
    if @title.nil?
     base_title
    else 
     "#{base_title} | #{@title}"
    end
   end 

   # Get the matches a player has played in a season
   def all_player_matches(player)
     result = Match.joins(:results).where(:results => {:player_id => player})
     @player_matches = Array.new
     result.each do |m|
       @player_matches << m.id
     end
     return @player_matches
   end
  end


  def match_result(match,player)
    scores = Result.where(:match_id => match)
       score_1 = scores.first
       score_2 = scores.last
       if score_1[:player_id] == player
         if score_1[:score] > score_2[:score]
           result = "won"
         elsif score_1[:score] == score_2[:score]
           result = "drew"       
         elsif score_1[:score] < score_2[:score]
           result = "lost"
           end
        elsif score_2[:player_id] == player
          if score_2[:score] > score_1[:score]
            result = "won"
          elsif score_2[:score] == score_1[:score]
            result = "drew"       
          elsif score_2[:score] < score_1[:score]
            result = "lost"
          end
        return result
        end
      end

  ##### This section is all about getting the players from the playerdiv 
  # Get players from current playerdiv
  def playerdiv_users(playerdiv)
    users = Hash.new
    results = User.joins(:playerdivs).where(:playerdivs => {:division_id => playerdiv})
    results.each do |r|
      users[r.name] = r.id
    end
    return users
  end


  # Gets everyone apart from the chosen player, and puts it in an array.
  def other_playerdiv_players_array(division,player_id)
    players = Array.new
    results = Player.joins(:playerdivs).where(:playerdivs => {:division_id => division}).where("players.id != ?", player_id)
    results.each do |r|
      players << r.id
    end
     players.sort!
     players.uniq!
     return players
  end

  ## Gets matches from a division
  def get_division_matches_played(division,player_ident)
    results = Match.where(:playerdiv_id => division)     #Get the users result from the current division

    @oppo_result = Array.new     #Get the opposition names in an active record relation
    results.each do |m|
      @oppo_result << Result.where(:match_id => m).where('player_id != ?', player_ident)
    end
    #return @oppo_result
    #Get the player_id out of the relation for each.
    @opposition = Array.new
    unless @oppo_result.blank?
      @oppo_result.each do |o|
        @opposition << o.first.player_id
      end
    end
     return @opposition
  end

  def unplayed_playerdiv_players(division,player_id)    
    others = other_playerdiv_players_array(division,player_id) #Get everyone who isn't us    
    played = get_division_matches_played(division,player_id) #Get the ones we've played against
    if others != played 
      unplayed = others - played #Subtract one from the other
      unplayedWithName = Hash.new #Put it in a hash and grab the name.
    
      unplayed.each do |u|
        player_name = Player.find(u).name
        unplayedWithName[player_name] = u
      end
      return unplayedWithName
    else
       unplayedWithName["empty"] = "true"
       return unplayedWithName
    end
  end

  # Get players from current playerdiv, return a hash

  def other_playerdiv_players(playerdiv,player_id)
    users = Hash.new
    results = Player.joins(:playerdivs).where(:playerdivs => {:division_id => playerdiv}).where("players.id != ?", player_id)
    results.each do |r|
      players[r.name] = r.id
    end
    return players
  end  

  # Get current playerdiv by id
  def get_playerdiv()
    playerdiv = Playerdiv.where(:player_id => current_player).last
    return playerdiv
  end

  # Get current playerdiv by id
  def get_playerdiv_by_id(id)
    current_season = current_season()
    playerdiv = Playerdiv.joins(:division).where(:divisions => {:season_id => current_season }).where(:playerdivs => {:player_id => id})
    return playerdiv
  end


  def player_by_id(id)
      player = Player.find(id)
      return player
  end


  def current_season()
  	now = Date.today
      Season.all.each do |s|
        if Date.today >= s.start_date && Date.today <= s.end_date
          return s.id
    	  end
      end
    end 

  def wanker(div_id)
    playerdivs = Array.new
    Playerdiv.where(:division_id => div_id).each do |p|
      playerdivs << p
    end
    return playerdivs
  end

  def current_divisions()
    div = Array.new
    curr_season = current_season()
    Division.where(:season_id => curr_season).each do |d|
      div << d.id
    end
    return div
  end



  def twitter_auth()
     Twitter.configure do |config|
       config.consumer_key = "MmLpCfZryJpziDQrP6v2fA"
       config.consumer_secret = "r1JnVOv0fqpKWf85PYy7NqIeujLlso7Rz77dMBz0GJM"
       config.oauth_token = "304956678-t1zBhgd9WPsLt2iPziMtMJUky7N67At8sBJOLVtE"
       config.oauth_token_secret = "S1Y9hkH9Sx9HOvXHzFDpceX1JyNZjKveaWmUl0QaMQ"
     end
   end
   
  def tweet_result(player1, player1_score, player2, player2_score)
     twitter_auth()
     # Create the tweet

     tweet = ["Result just in, ", player1, " ", player1_score, " - ", player2_score, " ",player2].join("")
     # Initialize your Twitter client
     client = Twitter::Client.new
     # Post a status update
     client.update(tweet)
   end




     def played_before(playerdiv,user1,user2)
      a = (playerdiv.to_s + user1.to_s + user2.to_s)
      if Match.where(:playerdiv => playerdiv).index == a.to_i
      return true
      else 
      return false
    end
end


