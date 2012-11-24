class PlayersController < ApplicationController

  def index
    #@players = Player.paginate(:page => params[:page]).order('name ASC')
    @players = Player.order(:name).page params[:page]
  end

	def show
	  @unplayed = unplayed_playerdiv_players(get_playerdiv().division_id,current_player.id)
	  @player = Player.find(params[:id])	  
	  if !Playerdiv.where(:player_id => params[:id]).empty?
      @currentDiv = Playerdiv.where(:player_id => params[:id]).last
      @playerDivMatch = Match.where(:playerdiv_id => @currentDiv.division_id)
    else
      @currentDiv = "nill"
      @playerDivMatch = "nill"
    end
    
	end

end