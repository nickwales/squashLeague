class MatchesController < ApplicationController
  include MatchesHelper
  # GET /matches
  # GET /matches.xml
  def index
    @matches = Match.paginate(:page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @matches }
    end
  end

  # GET /matches/1
  # GET /matches/1.xml
  def show
    @match = Match.find(params[:id])
    @result = Result.where(:match_id => params[:id])


    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @match }
    end
  end


  # GET /matches/new
  # GET /matches/new.xml
  def new
    @unplayed = other_playerdiv_players_array(get_playerdiv().division_id,current_player.id)
      #@unplayed = unplayed_playerdiv_players(get_playerdiv().id,current_player.id)
      #@unplayed = unplayed_playerdiv_players(get_playerdiv().division_id,current_player.id)
      #@playerdiv_players = other_playerdiv_player(get_playerdiv.division_id,current_player.id) 
    @players = 
    @match = Match.new
    1.times { @match.results.build }
    1.times { @match.rankings.build }
  
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @match }
    end
  end

  # GET /matches/1/edit
  def edit
    @match = Match.find(params[:id])
    @result = Result.where(:match_id => params[:id])
    0.times { @match.results.build }
  end

  # POST /matches
  # POST /matches.xml
  def create
    @unplayed = other_playerdiv_players_array(get_playerdiv().division_id,current_player.id)
    #We need to edit the params here a bit!
    #Fix players 2s elo player_id, easypeasy.
    params['match']['rankings_attributes']['1']['player_id'] = params['match']['results_attributes']['1']['player_id']
    player1 = params['match']['results_attributes']['0']['player_id']
    player2 = params['match']['results_attributes']['1']['player_id']
    player1_score = params['match']['results_attributes']['0']['score']
    player2_score = params['match']['results_attributes']['1']['score']

    #Add new elo scores 
    if params['match']['results_attributes']['0']['score'] > params['match']['results_attributes']['1']['score']
      elo_scores = update_elo_score(params['match']['results_attributes']['0']['player_id'],params['match']['results_attributes']['1']['player_id']) 
      params['match']['rankings_attributes']['0']['score'] = elo_scores.first     
      params['match']['rankings_attributes']['1']['score'] = elo_scores.last
    elsif params['match']['results_attributes']['0']['score'] < params['match']['results_attributes']['1']['score']
      elo_scores = update_elo_score(params['match']['results_attributes']['1']['player_id'],params['match']['results_attributes']['0']['player_id']) 
      params['match']['rankings_attributes']['1']['score'] = elo_scores.first     
      params['match']['rankings_attributes']['0']['score'] = elo_scores.last
    else
      elo_scores = dont_update_elo_score(params['match']['results_attributes']['0']['player_id'],params['match']['results_attributes']['1']['player_id']) 
      params['match']['rankings_attributes']['0']['score'] = elo_scores.first     
      params['match']['rankings_attributes']['1']['score'] = elo_scores.last      
    end
    

    @match = Match.new(params[:match])
    respond_to do |format|
     if @match.save
       if Rails.env.production?
         player1_info = player.find(player1)
         if player1_info.twitter.blank?
           player1_name = player1_info.name
         else 
           if player1_info.twitter.include? "@"
              player1_name = player1_info.twitter
            else 
              player1_name = ["@",player1_info.twitter].join("")
            end
         end

         player2_info = player.find(player2)
         if player2_info.twitter.blank?
           player2_name = player2_info.name
         else 
           if player2_info.twitter.include? "@"
             player2_name = player2_info.twitter
           else 
             player2_name = ["@",player2_info.twitter].join("")
           end
         end
         
         if !player1_score == "-1" or !player2_score == "-1"
           tweet_result(player1_name,player1_score,player2_name,player2_score)
         end
        ResultMailer.result_email(params['match']['rankings_attributes']['0']['player_id'],params['match']['rankings_attributes']['1']['player_id'],params['match']['results_attributes']['0']['score'],params['match']['results_attributes']['1']['score']).deliver
         end    

        format.html { redirect_to(@match, :notice => 'Match was successfully created.') }
        format.xml  { render :xml => @match, :status => :created, :location => @match }      
      else
#        format.html { render :action => "new"}
        format.html { redirect_to new_match_path, :alert => 'You did not enter any scores' }
        format.xml  { render :xml => @match.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /matches/1
  # PUT /matches/1.xml
  def update
    @match = Match.find(params[:id])
    @result = Result.where(:match_id => params[:id])
    respond_to do |format|
      if @match.update_attributes(params[:match])
        format.html { redirect_to(@match, :notice => 'Match was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @match.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.xml
  def destroy
    @match = Match.find(params[:id])
    @match.destroy

    respond_to do |format|
      format.html { redirect_to(root_to) }
      format.xml  { head :ok }
    end
  end
end
